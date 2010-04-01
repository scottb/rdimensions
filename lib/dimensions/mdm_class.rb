module Dimensions
  class MDMClass < Field
    attr_reader :mdm_class
    attr_reader :fields

    def base_name
      parent.base_name
    end

    def variable_instances
      @variable_instances ||= fields.map do |f|
	VariableInstance.new( self, "#{name}.#{f.name}")
      end
    end
  end
end
