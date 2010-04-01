module Dimensions
  class Field < MDMNode
    include MDMObject
    include LabeledObject

    attr_reader :categories
    attr_reader :data_type
    attr_reader :mdm_class
  end
end
