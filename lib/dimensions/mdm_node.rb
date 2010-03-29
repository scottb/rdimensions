module Dimensions
  class MDMNode
    attr_reader :node

    def initialize( document, node)
      @document = document
      @node = node
    end
  end
end
