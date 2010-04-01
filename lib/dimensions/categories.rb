module Dimensions
  class Categories < MDMNode
    attr_accessor :name
    attr_accessor :uuid
    attr_accessor :categories
    attr_accessor :categoriesref

    def closure
      result = []
      result.concat( self)
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

  class CategoriesProxy < MDMNode
    def delegate
      @delegate ||= @document.categories.find {|c| c.uuid == @categoriesref }
    end

    def respond_to?( method)
      delegate.respond_to?( method) || super
    end

    def method_missing( method, *args, &block)
      return delegate.send( method, *args, &block) if delegate.respond_to?( method)
      super
    end

    def inspect
      "#<#{self.class}:#{object_id} @document=#{@document.inspect}, @delegate=#{@delegate.inspect}>"
    end
  end
end
