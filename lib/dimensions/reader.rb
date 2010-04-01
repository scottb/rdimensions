module Dimensions
  class Document
    class << self
      def read( filename)
	f = open( filename)
	result = Factory.build( f)
	f.close
	result
      end
    end
  end

  class Factory
    class << self
      def build( source)
	result = Document.new
	result.instance_exec do
	  @xml = Nokogiri::XML( source)
	  metadata = @xml.root.children.first
	  @uuids = Hash[ metadata.xpath( './/*[@id]').map {|node| [ node[ 'id'], node ]}]

	  # datasources
	  @data_sources = metadata.xpath( 'datasources/connection').map do |node|
	    Connection.build( self, node) do |node|
	      @name = node[ 'name']
	      @dblocation = node[ 'dblocation']
	      @cdscname = node[ 'cdscname']
	      @project = node[ 'project']
	    end
	  end
	  @data_sources.extend( DataSources).with_default( metadata.xpath( 'datasources/@default').first.value)

	  # definition
	  @variables = metadata.xpath( 'definition/variable').map do |node|
	    VariableDefinition.build( self, node) do |node|
	      @uuid = node[ 'id']
	      @name = node[ 'name']
	      @has_case_data = !( node.has_attribute?( 'no-casedata') && node[ 'no-casedata'] == '-1')
	      @data_type = Document.get_type( node[ 'type'].to_i)
	      @labels = Factory.build_labels_for( node)
	      @categories = Factory.build_categories_for( self, node).first
	      @mdm_class = Factory.build_class_for( self, node)
	    end
	  end
	  @categories = Factory.build_categories_for( self, metadata.xpath( 'definition').first)
	  # TODO: definition/page

	  # system
	  # systemrouting
	  # mappings

	  # design
	  @fields = Factory.build_fields_for( self, metadata.xpath( 'design').first)

	  # languages
	  @languages = metadata.xpath( 'languages/language').map do |node|
	    Language.build( self, node) do |node|
	      @xml_name = node[ 'name']
	    end
	  end

	  # contexts
	  @contexts = metadata.xpath( 'contexts/context').map do |node|
	    Context.build( self, node) do |node|
	      @name = node[ 'name']
	    end
	  end
	  @contexts.extend( Contexts).with_base( metadata.xpath( 'contexts/@base').first.value)

	  # labeltypes
	  @label_types = metadata.xpath( 'labeltypes/context').map do |node|
	    Context.build( self, node) do |node|
	      @name = node[ 'name']
	    end
	  end
	  @label_types.extend( Contexts).with_base( metadata.xpath( 'labeltypes/@base').first.value)

	  # routingcontexts
	  @routing_contexts = metadata.xpath( 'routingcontexts/context').map do |node|
	    Context.build( self, node) do |node|
	      @name = node[ 'name']
	    end
	  end
	  @routing_contexts.extend( Contexts).with_base( metadata.xpath( 'routingcontexts/@base').first.value)

	  # scripttypes
	  # versions
	  # savelogs
	  # atoms

	  # versionlist
	  @created_by_version = metadata.xpath( 'versionlist/version[1]/@mdmversion').first.value
	  @last_updated_by_version = metadata.xpath( 'versionlist/version[last()]/@mdmversion').first.value

	  # categorymap
	  @category_map = Hash[ metadata.xpath( 'categorymap/categoryid').map {|node| [ node[ 'name'], node[ 'value'].to_i ] }]

	  @labels = Factory.build_labels_for( metadata)
	end
	result
      end
    end

  private
    def self.build_fields_for( owner, node)
      node.xpath( 'fields').first.children.map do |node|
	case node.name
	when 'variable'
	  if node.has_attribute?( 'ref')
	    VariableProxy.build( owner, node) do
	      @delegate = owner.document.variables.find {|v| v.uuid == node[ 'ref'] }
	    end
	  else
	    VariableDefinition.build( owner, node) do |node|
	      @uuid = node[ 'ref']
	      @name = node[ 'name']
	      @has_case_data = !( node.has_attribute?( 'no-casedata') && node[ 'no-casedata'] == '-1')
	      @data_type = Document.get_type( node[ 'type'].to_i)
	      @labels = Factory.build_labels_for( node)
	      @categories = Factory.build_categories_for( self, node).first
	      @mdm_class = Factory.build_class_for( self, node)
	    end
	  end
	when 'loop'
	  MDMArray.build( owner, node) do |node|
	    @uuid = node[ 'ref']
	    @name = node[ 'name']
	    @labels = Factory.build_labels_for( node)
	    @categories = Factory.build_categories_for( self, node).first
	    @mdm_class = Factory.build_class_for( self, node)
	  end
	when 'class'
	  MDMClass.build( owner, node) do |node|
	    @name = node[ 'name']
	  end
	else
	  nil
	end
      end.compact
    end

    def self.build_class_for( owner, node)
      cnode = node.xpath( 'class').first
      cnode && MDMClass.build( owner, cnode) do |node|
	@name = node[ 'name']
	@fields = Factory.build_fields_for( self, node)
      end
    end

    def self.build_categories_for( owner, node)
      node.xpath( 'categories').map do |cnode|
	Categories.build( owner, cnode) do |node|
	  @name = node[ 'name']
	  @uuid = node[ 'id']
	  @categories = Factory.build_categories_for( self, cnode).first
	  @categoriesref = node[ 'categoriesref']
	  @elements = node.xpath( 'category').map do |n|
	    MDMElement.build( owner, n) do |node|
	      @name = node[ 'name']
	      @labels = Factory.build_labels_for( node)
	    end
	  end
	end
      end
    end

    def self.build_labels_for( node)
      result = {}
      node.xpath( 'labels').each do |n|
	context = n[ 'context']
	result[ context.downcase.to_sym] = Factory.build_text_index_for( n).extend( Label).with_context( context)
      end
      result
    end

    def self.build_text_index_for( node)
      result = {}
      node.xpath( 'text').each do |node|
	context = node[ 'context'].downcase.to_sym
	result[ context] ||= {}
	result[ context][ node[ 'lang']] = node.content
      end
      result
    end
  end
end
