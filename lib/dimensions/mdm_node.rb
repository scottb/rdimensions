module Dimensions
  class MDMNode
    attr_reader :node

    def initialize( document, node)
      @document = document
      @node = node
    end

    def inspect
      "#<#{self.class}:#{object_id} @document=#{@document}, @node=#{@node.path}>"
    end

    alias to_s inspect
  end
end
