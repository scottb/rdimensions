module Dimensions
  module MDMObject
    attr_reader :document
    attr_reader :uuid
    attr_reader :name

    def full_name
      parent.base_name == '' ? name : "#{parent.base_name}.#{name}"
    end

    def base_name
      name
    end
  end
end
