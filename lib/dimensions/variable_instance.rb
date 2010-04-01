module Dimensions
  class VariableInstance < MDMNode
    attr_reader :name

    def initialize( parent, name)
      super( parent)
      @name = name
    end
  end
end
