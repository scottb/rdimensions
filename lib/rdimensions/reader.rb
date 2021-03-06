class Nokogiri::XML::Element
  # this is inexplicably missing from nokogiri 1.4.1
  def at_xpath( path)
    xpath( path).first
  end
end

module RDimensions
  class Document
    class << self
      def read( filename)
	f = open( filename)
	result = Factory.build( Nokogiri::XML( f))
	f.close
	result
      end

      def parse( mdd_string)
	Factory.build( Nokogiri::XML( mdd_string))
      end
    end
  end


  class Factory
    class << self
      def build( source)
	result = Document.new
	result.instance_exec do
	  @xml = source
	  metadata = @xml.root.at_xpath( '*[local-name() = "metadata"]')

	  @data_sources = Factory.build_connections_for( self, metadata.at_xpath( 'datasources'))
	  @othervariables = metadata.xpath( 'definition/othervariable').map {|node| Factory.build_variable_for( self, node) }
	  @variables = metadata.xpath( 'definition/variable').map {|node| Factory.build_variable_for( self, node) }
	  @categories = Factory.build_categories_for( self, metadata.at_xpath( 'definition'))

	  # TODO: definition/page
	  # TODO: system
	  # TODO: systemrouting
	  # TODO: mappings

	  @fields = Factory.build_fields_for( self, metadata.at_xpath( 'system'), true) + Factory.build_fields_for( self, metadata.at_xpath( 'design/fields'))
	  @languages = metadata.xpath( 'languages/language').map {|node| Factory.build_language_for( self, node) }
	  @languages_base = metadata.at_xpath( 'languages/@base')
	  @languages_base = @languages_base.value.downcase if @languages_base
	  @contexts = Factory.build_contexts_for( self, metadata.at_xpath( 'contexts'))
	  @label_types = Factory.build_contexts_for( self, metadata.at_xpath( 'labeltypes'))
	  @routing_contexts = Factory.build_contexts_for( self, metadata.at_xpath( 'routingcontexts'))

	  # TODO: scripttypes
	  # TODO: versions
	  # TODO: savelogs
	  # TODO: atoms

	  node = metadata.at_xpath( 'versionlist/version[1]/@mdmversion')
	  @created_by_version = node.value if node

	  node = metadata.at_xpath( 'versionlist/version[last()]/@mdmversion')
	  @last_updated_by_version = node.value if node

	  @category_map = Hash[ metadata.xpath( 'categorymap/categoryid').map {|node| [ node[ 'name'], node[ 'value'].to_i ] }]

	  @labels = Factory.build_labels_for( metadata)
	end
	result
      end
    end

  private
    def self.build_variable_for( parent, node, system = false)
      if node.has_attribute?( 'ref')
	VariableProxy.build( parent, node) do
	  @name = node[ 'name']
	  @delegate = parent.document.variables.find {|v| v.uuid == node[ 'ref'] }
	  raise "Delegate not found for #{node[ 'ref']} at #{node.path}" unless @delegate
	end
      else
	VariableDefinition.build( parent, node) do |node|
	  @system = system
	  @uuid = node[ 'id']
	  @name = node[ 'name']
	  @min_value = node[ 'min'].to_i if node.has_attribute? 'min'
	  @max_value = node[ 'max'].to_i if node.has_attribute? 'max'
	  @has_case_data = !( node.has_attribute?( 'no-casedata') && node[ 'no-casedata'] == '-1')
	  @data_type = Document.get_type( node[ 'type'].to_i)
	  @labels = Factory.build_labels_for( node)
	  @categories = Factory.build_categories_for( self, node)
	  @mdm_class = Factory.build_class_for( self, node.at_xpath( 'class'))
	end
      end
    end

    def self.build_othervariables_for( parent, node)
      node.xpath( 'othervariable').map do |onode|
	if onode.has_attribute?( 'ref')
	  VariableProxy.build( node, onode) do
	    @name = onode[ 'name']
	    @delegate = parent.document.othervariables.find {|v| v.uuid == onode[ 'ref'] }
	    raise "Delegate not found for #{onode[ 'ref']} at #{onode.path}" unless @delegate
	  end
	else
	  raise "Expected delegate, not definition at #{node.path}"
	end
      end
    end

    def self.build_array_for( parent, node, system = false)
      MDMArray.build( parent, node) do |node|
	@system = system
	@uuid = node[ 'ref']
	@name = node[ 'name']
	@labels = Factory.build_labels_for( node)
	@categories = Factory.build_categories_for( self, node)
	@mdm_class = Factory.build_class_for( self, node.at_xpath( 'class'), system)
      end
    end

    def self.build_fields_for( parent, node, system = false)
      node.children.map do |node|
	case node.name
	when 'variable'
	  Factory.build_variable_for( parent, node, system)
	when 'loop'
	  Factory.build_array_for( parent, node, system)
	when 'class'
	  Factory.build_class_for( parent, node, system)
	else
	  nil
	end
      end.compact
    end

    def self.build_class_for( parent, cnode, system = false)
      cnode && MDMClass.build( parent, cnode) do |node|
	@system = system
	@name = node[ 'name']
	@fields = Factory.build_fields_for( self, node.at_xpath( 'fields'))
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
	    @categories = Factory.build_categories_for( self, cnode)
	    @elements = node.xpath( 'category').map do |n|
	      Category.build( self, n) do |node|
		@name = node[ 'name']
		@labels = Factory.build_labels_for( node)
		@othervariables = Factory.build_othervariables_for( self, node)
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
      default = node.at_xpath( '@default')
      default = default.value if default
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
	result[ context][ node[ 'xml:lang']] = node.content
      end
      result
    end
  end
end
