module Dimensions
  class VariableInstance
    attr_accessor :name
    attr_accessor :field

    def initialize( name, field)
      @name, @field = name, field
    end
  end

  class Document
    def build_variable_instances
      Document.sum fields.map {|f| f.variable_instances }, []
    end
  end

  module Variable
    def build_variable_instances
      [ VariableInstance.new( name, self) ]
    end
  end

  class MDMArray
    def build_variable_instances
      mdm_class.fields.map do |field|
	categories.map do |c|
	  iname = Document.make_instance_name( "#{name}[..]", c.to_index)
	  field.build_variable_instances.each {|vi| vi.name = "#{iname}.#{vi.name}" }
	end
      end.flatten
    end
  end

  class MDMClass
    def build_variable_instances
      fields.map( &:build_variable_instances).flatten.each do |vi|
	vi.name = "#{name}.#{vi.name}"
      end
    end
  end
end
