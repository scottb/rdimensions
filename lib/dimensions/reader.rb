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
	    Connection.build( self, node) do |doc,node|
	      @name = node[ 'name']
	      @dblocation = node[ 'dblocation']
	      @cdscname = node[ 'cdscname']
	      @project = node[ 'project']
	    end
	  end
	  @data_sources.extend( DataSources).with_default( metadata.at( 'datasources/@default').value)

	  # definition
	  @defined_variables = metadata.xpath( 'definition/variable').map do |node|
	    Variable.build( self, node) do |doc,node|
	      @uuid = node[ 'id']
	      @name = node[ 'name']
	      @has_case_data = !( node.has_attribute?( 'no-casedata') && node[ 'no-casedata'] == '-1')
	      @data_type = Document.get_type( node[ 'type'].to_i)
	      @labels = Factory.build_labels_for( doc, node)
	      @categories = Factory.build_categories_for( doc, node)
	    end
	  end
	  @defined_categories = Factory.build_categories_for( self, metadata.at( 'definition'))
	  # TODO: definition/page

	  # system
	  # systemrouting
	  # mappings

	  # design
	  @fields = metadata.at( 'design/fields').children.map do |node|
	    case node.name
	    when 'variable'
	      if node.has_attribute?( 'ref')
		@defined_variables.find {|v| v.uuid == node[ 'ref'] }
	      else
		Variable.build( self, node) do |doc,node|
		  @uuid = node[ 'ref']
		  @name = node[ 'name']
		  @has_case_data = !( node.has_attribute?( 'no-casedata') && node[ 'no-casedata'] == '-1')
		  @data_type = Document.get_type( node[ 'type'].to_i)
		  @labels = Factory.build_labels_for( doc, node)
		  @categories = Factory.build_categories_for( doc, node)
		end
	      end
	    when 'loop'
	      MDMArray.build( self, node) do |doc,node|
		@uuid = node[ 'ref']
		@name = node[ 'name']
		@labels = Factory.build_labels_for( doc, node)
		@categories = Factory.build_categories_for( doc, node)
	      end
	    when 'class'
	      nil
	    else
	      nil
	    end
	  end.compact

	  # languages
	  @languages = metadata.xpath( 'languages/language').map do |node|
	    Language.build( self, node) do |doc,node|
	      @xml_name = node[ 'name']
	    end
	  end

	  # contexts
	  @contexts = metadata.xpath( 'contexts/context').map do |node|
	    Context.build( self, node) do |doc,node|
	      @name = node[ 'name']
	    end
	  end
	  @contexts.extend( Contexts).with_base( metadata.at( 'contexts/@base').value)

	  # labeltypes
	  @label_types = metadata.xpath( 'labeltypes/context').map do |node|
	    Context.build( self, node) do |doc,node|
	      @name = node[ 'name']
	    end
	  end
	  @label_types.extend( Contexts).with_base( metadata.at( 'labeltypes/@base').value)

	  # routingcontexts
	  @routing_contexts = metadata.xpath( 'routingcontexts/context').map do |node|
	    Context.build( self, node) do |doc,node|
	      @name = node[ 'name']
	    end
	  end
	  @routing_contexts.extend( Contexts).with_base( metadata.at( 'routingcontexts/@base').value)

	  # scripttypes
	  # versions
	  # savelogs
	  # atoms

	  # versionlist
	  @created_by_version = metadata.at( 'versionlist/version[1]/@mdmversion').value
	  @last_updated_by_version = metadata.at( 'versionlist/version[last()]/@mdmversion').value

	  # categorymap
	  @category_map = Hash[ metadata.xpath( 'categorymap/categoryid').map {|node| [ node[ 'name'], node[ 'value'].to_i ] }]

	  @labels = Factory.build_labels_for( self, metadata)
	end
	result
      end
    end

  private
    def self.build_labels_for( doc, node)
      result = {}
      node.xpath( 'labels').each do |n|
	context = n[ 'context']
	result[ context.downcase.to_sym] = Factory.build_text_index_for( n).extend( Label).with_context( context)
      end
      result
    end

    def self.build_categories_for( doc, node)
      node.xpath( 'categories/category').map do |n|
	MDMElement.build( doc, n) do |doc,node|
	  @name = node[ 'name']
	  @labels = Factory.build_labels_for( doc, node)
	end
      end
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
