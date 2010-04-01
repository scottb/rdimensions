module Dimensions
  module MDMObject
    attr_reader :document
    attr_reader :uuid
    attr_reader :name

    def full_name
      "#{parent.name_prefix}#{name}"
    end

    def name_prefix
      "#{name}."
    end
  end
end
