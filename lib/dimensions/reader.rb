class Nokogiri::XML::Element
  # this is inexplicably missing from nokogiri 1.4.1
  def at_xpath( path)
    xpath( path).first
  end
end

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

    def build_variable_instances
      []
    end
  end

  class Factory
    class << self
      def build( source)
	result = Document.new
	result.instance_exec do
	  @xml = Nokogiri::XML( source)
	  metadata = @xml.root.children.first

	  @data_sources = Factory.build_connections_for( self, metadata.at_xpath( 'datasources'))
	  @variables = metadata.xpath( 'definition/variable').map {|node| Factory.build_variable_for( self, node) }
	  @categories = Factory.build_categories_for( self, metadata.at_xpath( 'definition'))
	  # TODO: definition/page
	  # TODO: system
	  # TODO: systemrouting
	  # TODO: mappings
	  @fields = Factory.build_fields_for( self, metadata.at_xpath( 'design'))
	  @languages = metadata.xpath( 'languages/language').map {|node| Factory.build_language_for( self, node) }
	  @contexts = Factory.build_contexts_for( self, metadata.at_xpath( 'contexts'))
	  @label_types = Factory.build_contexts_for( self, metadata.at_xpath( 'labeltypes'))
	  @routing_contexts = Factory.build_contexts_for( self, metadata.at_xpath( 'routingcontexts'))
	  # TODO: scripttypes
	  # TODO: versions
	  # TODO: savelogs
	  # TODO: atoms
	  @created_by_version = metadata.at_xpath( 'versionlist/version[1]/@mdmversion').value
	  @last_updated_by_version = metadata.at_xpath( 'versionlist/version[last()]/@mdmversion').value
	  @category_map = Hash[ metadata.xpath( 'categorymap/categoryid').map {|node| [ node[ 'name'], node[ 'value'].to_i ] }]

	  @variable_instances = build_variable_instances
	  @labels = Factory.build_labels_for( metadata)
	end
	result
      end
    end

  private
    def self.build_variable_for( parent, node)
      if node.has_attribute?( 'ref')
	VariableProxy.build( parent, node) do
	  @name = node[ 'name']
	  @delegate = parent.document.variables.find {|v| v.uuid == node[ 'ref'] }
	  raise "Delegate not found for #{node[ 'ref']} at #{node.path}" unless @delegate
	end
      else
	VariableDefinition.build( parent, node) do |node|
	  @uuid = node[ 'id']
	  @name = node[ 'name']
	  @has_case_data = !( node.has_attribute?( 'no-casedata') && node[ 'no-casedata'] == '-1')
	  @data_type = Document.get_type( node[ 'type'].to_i)
	  @labels = Factory.build_labels_for( node)
	  @categories = Factory.build_categories_for( self, node).first
	  @mdm_class = Factory.build_class_for( self, node)
	end
      end
    end

    def self.build_fields_for( parent, node)
      node.at_xpath( 'fields').children.map do |node|
	case node.name
	when 'variable'
	  build_variable_for( parent, node)
	when 'loop'
	  MDMArray.build( parent, node) do |node|
	    @uuid = node[ 'ref']
	    @name = node[ 'name']
	    @labels = Factory.build_labels_for( node)
	    @categories = Factory.build_categories_for( self, node).first
	    @mdm_class = Factory.build_class_for( self, node)
	  end
	when 'class'
	  MDMClass.build( parent, node) do |node|
	    @name = node[ 'name']
	  end
	else
	  nil
	end
      end.compact
    end

    def self.build_class_for( parent, node)
      cnode = node.at_xpath( 'class')
      cnode && MDMClass.build( parent, cnode) do |node|
	@name = node[ 'name']
	@fields = Factory.build_fields_for( self, node)
      end
    end

    def self.build_categories_for( parent, node)
      node.xpath( 'categories').map do |cnode|
	if cnode.has_attribute?( 'categoriesref')
	  CategoriesProxy.build( parent, cnode) do |node|
	    @categoriesref = node[ 'categoriesref']
	  end
	else
	  Categories.build( parent, cnode) do |node|
	    @name = node[ 'name']
	    @uuid = node[ 'id']
	    @categories = Factory.build_categories_for( self, cnode).first
	    @elements = node.xpath( 'category').map do |n|
	      MDMElement.build( parent, n) do |node|
		@name = node[ 'name']
		@labels = Factory.build_labels_for( node)
	      end
	    end
	  end
	end
      end
    end

    def self.build_language_for( parent, node)
      Language.build( parent, node) do |node|
	@xml_name = node[ 'name']
      end
    end

    def self.build_contexts_for( parent, node)
      base = node[ 'base']
      result = node.xpath( 'context').map do |cnode|
	Context.build( parent, cnode) do |node|
	  @name = node[ 'name']
	end
      end
      result.extend( Contexts).with_base( base)
    end

    def self.build_connections_for( parent, node)
      default = node.at_xpath( '@default').value
      result = node.xpath( 'connection').map do |cnode|
	Connection.build( parent, cnode) do |node|
	  @name = node[ 'name']
	  @dblocation = node[ 'dblocation']
	  @cdscname = node[ 'cdscname']
	  @project = node[ 'project']
	end
      end
      result.extend( DataSources).with_default( default)
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
