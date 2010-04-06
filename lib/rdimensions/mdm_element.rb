module RDimensions
  class MDMElement < MDMNode
    include MDMObject
    include LabeledObject

    def to_index
      "{#{name}}"
    end
  end
end
