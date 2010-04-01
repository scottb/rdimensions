module Dimensions
  class MDMArray < Field
    def base_name
      "#{name}[..]"
    end

    def variable_instances
      @variable_instances ||= mdm_class.fields.map do |field|
	if field.is_a?( MDMClass)
	  field.fields.map do |f|
	    categories.map {|c|VariableInstance.new( self, Document.make_instance_name( "#{f.parent.full_name}.#{f.name}", "{#{c.name}}")) }
	  end
	else
	  field.full_name	# e.g., 'GRQ9[..].Q9'
	  categories.map {|c| VariableInstance.new( self, Document.make_instance_name( field.full_name, "{#{c.name}}")) }
	end
      end.compact.flatten
    end
  end
end
