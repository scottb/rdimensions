module Dimensions
  class MDMClass < Field
    attr_reader :mdm_class
    attr_reader :fields

    def name_prefix
      parent.name_prefix
    end
  end
end
