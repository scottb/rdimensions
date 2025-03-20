module RDimensions
  class Category < MDMElement
    attr_reader :othervariables
  end

  class Categories < MDMNode
    attr_reader :name
    attr_reader :uuid
    attr_reader :categories
    attr_reader :categoriesref

    def closure
      @elements + Document.sum(@categories.map(&:closure), [])
    end

    def respond_to?(method, include_all = false)
      @elements.respond_to?(method, include_all) || super
    end

    def method_missing(method, ...)
      return @elements.send(method, ...) if @elements.respond_to?(method)

      super
    end
  end

  class CategoriesProxy < MDMNode
    def delegate
      @delegate ||= @document.categories.find {|c| c.uuid == @categoriesref }
    end

    def respond_to?(method, include_all = false)
      delegate.respond_to?(method, include_all) || super
    end

    def method_missing(method, ...)
      return delegate.send(method, ...) if delegate.respond_to?(method)

      super
    end

    def inspect
      "#<#{self.class}:#{object_id} @document=#{@document.inspect}, @delegate=#{@delegate.inspect}>"
    end
  end
end
