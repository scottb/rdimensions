module Dimensions
  module Contexts
    attr_reader :base
    attr_writer :current

    def current
      @current || base
    end

    def with_base( s)
      @base = s
      self
    end
  end

  class Document
    include MDMObject
    attr_accessor :xml
    attr_reader :node

    def self.read( filename, &block)
      f = open( filename)
      result = Document.new( f, &block)
      f.close
      result
    end

    def self.mdm_version
      '5.0.3.3066'
    end

    def initialize( xml)
      @xml = Nokogiri::XML( xml)
      @node = @xml.root.children.first
      @uuids = @node.xpath( '*[@id]').map {|node| [ node[ 'id'], node ]}
      yield self if block_given?
    end

    def created_by_version
      @created_by_version ||= @node.at( 'versionlist/version[1]/@mdmversion').value
    end

    def last_updated_by_version
      @created_by_version ||= @node.at( 'versionlist/version[last()]/@mdmversion').value
    end

    def category_map
      @category_map ||= Hash[ @node.xpath( 'categorymap/categoryid').map {|node| [ node[ 'name'], node[ 'value'].to_i ] }]
    end
    
    def label_types
      @label_types ||= @node.xpath( 'labeltypes/context').map {|node| Context.new( self, node) }.extend( Contexts).with_base( @node.at( 'labeltypes/@base').value)
    end

    def contexts
      @contexts ||= @node.xpath( 'contexts/context').map {|node| Context.new( self, node) }.extend( Contexts).with_base( @node.at( 'contexts/@base').value)
    end
  end
end
