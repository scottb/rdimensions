module Dimensions
  module Variable
    def variable_instances
      @variable_instances ||= [ VariableInstance.new( self, full_name) ]
    end
  end

  class VariableDefinition < Field
    include Variable
    def has_case_data?
      @has_case_data
    end
  end

  class VariableProxy < MDMNode
    include Variable
    attr_accessor :name

    def full_name
      parent.base_name == '' ? name : "#{parent.base_name}.#{name}"
    end

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
