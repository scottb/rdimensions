module Dimensions
  class MDMClass < MDMNode
    include MDMObject
    attr_reader :mdm_class
    attr_reader :fields
  end
end
