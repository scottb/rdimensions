module Dimensions
  class MDMNode
    def initialize( document)
      @document = document
    end

    def inspect
      "#<#{self.class}:#{object_id} @document=#{@document}>"
    end

    def self.build( document, node, &block)
      result = new( document)
      result.instance_exec( document, node, &block) if block
      result
    end

    alias to_s inspect
  end
end
