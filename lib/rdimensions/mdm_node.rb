module RDimensions
  class MDMNode
    def initialize( parent)
      @document = parent.document
      @parent = parent
    end

    attr_reader :document
    attr_reader :parent

    def inspect
      "#<#{self.class}:#{object_id} @document=#{@document.inspect}>"
    end

    def self.build( parent, node, &block)
      result = new( parent)
      result.instance_exec( node, &block) if block
      result
    end

    alias to_s inspect
  end
end
