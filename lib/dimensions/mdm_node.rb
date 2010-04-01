module Dimensions
  class MDMNode
    def initialize( parent)
      @document = parent.document
      @parent = parent
    end

    attr_accessor :document
    attr_accessor :parent

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
