module RDimensions
  module Variable
  end

  class VariableDefinition < Field
    include Variable
    def has_case_data?
      @has_case_data
    end
  end

  class VariableProxy < MDMNode
    include Variable
    attr_reader :name

    def method_missing( method, *args, &block)
      return @delegate.send( method, *args, &block) if @delegate.respond_to?( method)
      super
    end

    def respond_to?( method)
      @delegate.respond_to?( method) || super
    end

    def inspect
      "#<#{self.class}:#{object_id} @document=#{@document.inspect}, @delegate=#{@delegate.inspect}>"
    end
  end
end