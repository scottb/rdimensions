module Dimensions
  class MDMClass < MDMNode
    include MDMObject
    attr_reader :mdm_class
    attr_reader :fields

    def name_prefix
      parent.name_prefix
    end
  end
end
