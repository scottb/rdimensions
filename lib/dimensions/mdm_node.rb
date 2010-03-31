module Dimensions
  class MDMNode
    def initialize( document, node)
      @document = document
      @node = node
    end

    def inspect
      "#<#{self.class}:#{object_id} @document=#{@document}, @node=#{@node.path}>"
    end

    def self.build( document, node, &block)
      result = new( document, node)
      result.instance_exec( document, node, &block) if block
      result
    end

    alias to_s inspect
  end
end
