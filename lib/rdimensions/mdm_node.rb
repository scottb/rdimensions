module RDimensions
  class MDMNode
    def initialize( parent, node)
      @document = parent.document
      @parent = parent
      @xml = node
    end

    attr_reader :document
    attr_reader :parent
    attr_reader :xml

    def inspect
      "#<#{self.class}:#{object_id} @document=#{@document.inspect}>"
    end

    def self.build( parent, node, &block)
      result = new( parent, node)
      result.instance_exec( node, &block) if block
      result
    end

    alias to_s inspect
  end
end
