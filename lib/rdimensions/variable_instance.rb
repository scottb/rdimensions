module RDimensions
  class VariableInstance
    attr_accessor :name
    attr_reader :sources

    def initialize( name, source)
      @name, @sources = name, [ source ]
    end

    def add_source( name, *sources)
      @name = "#{name}.#{@name}"
      @sources = sources + @sources
    end
  end

  class Document
    def build_variable_instances
      Document.sum fields.map {|f| f.variable_instances }, []
    end
  end

  module Variable
    def build_variable_instances
      result = [ VariableInstance.new( name, self) ]
      categories.each do |cat|
	result += Document.sum( cat.map {|c| c.build_variable_instances( name) }, [])
      end
      result
    end
  end

  class Category
    def build_variable_instances( parent_name)
      othervariables.map {|v| VariableInstance.new( "#{parent_name}.#{v.name}", v) }
    end
  end

  class MDMArray
    def build_variable_instances
      mdm_class.fields.map do |field|
	categories.map do |cat|
	  cat.map do |c|
	    iname = Document.make_instance_name( "#{name}[..]", c.to_index)
	    field.build_variable_instances.each {|vi| vi.add_source( iname, self, c) }
	  end
	end
      end.flatten
    end
  end

  class MDMClass
    def build_variable_instances
      fields.map( &:build_variable_instances).flatten.each {|vi| vi.add_source( name, self) }
    end
  end
end
