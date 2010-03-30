module Dimensions
  class Document
    include MDMObject
    include LabeledObject
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

    def document
      self
    end

    def url
      @node.document.url
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

    def contexts
      @contexts ||= Contexts.build_contexts_for( 'contexts', self)
    end

    def label_types
      @label_types ||= Contexts.build_contexts_for( 'labeltypes', self)
    end

    def routing_contexts
      @label_types ||= Contexts.build_contexts_for( 'routingcontexts', self)
    end

    def log_action
      raise NotYetImplementedException
    end
    alias valid? log_action
    alias valid_version? log_action
    alias join log_action
    alias join_conflicts log_action

    def inspect
      "#<#{self.class}:#{object_id}>"
    end

    alias to_s inspect
  end
end
