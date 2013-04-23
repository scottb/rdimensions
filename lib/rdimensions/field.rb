module RDimensions
  class Field < MDMNode
    include MDMObject
    include LabeledObject

    attr_reader :categories
    attr_reader :data_type
    attr_reader :mdm_class

    def system?
      @system
    end

    def closed_categories
      Document.sum( @categories.map( &:closure), [])
    end

    def variable_instances
      @variable_instances ||= build_variable_instances
    end
  end
end
