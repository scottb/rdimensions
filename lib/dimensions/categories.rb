module Dimensions
  class Categories < MDMNode
    attr_accessor :name
    attr_accessor :uuid
    attr_accessor :categories
    attr_accessor :categoriesref

    def closure
      result = []
      result.concat( self)
      result.concat( @document.categories.find {|c| c.uuid == @categoriesref }.closure)if @categoriesref
      result.concat( @categories.closure) if @categories
      result
    end

    def respond_to?( method)
      @elements.respond_to?( method) || super
    end

    def method_missing( method, *args, &block)
      return @elements.send( method, *args, &block) if @elements.respond_to?( method)
      super
    end
  end
end
