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
    attr_accessor :name

    def full_name
      "#{parent.name_prefix}#{name}"
    end

    def method_missing( method, *args, &block)
      return @delegate.send( method, *args, &block) if @delegate.respond_to?( method)
      super
    end

    def respond_to?( method)
      @delegate.respond_to?( method) || super
    end
  end
end
