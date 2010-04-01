module Dimensions
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
    def method_missing( method, *args, &block)
      @delegate.send( method, *args, &block) if @delegate.respond_to?( method)
    end

    def respond_to?( method)
      @delegate.respond_to?( method) || super
    end
  end
end
