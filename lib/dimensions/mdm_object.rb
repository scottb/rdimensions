module Dimensions
  module MDMObject
    attr_reader :document
    attr_reader :uuid
    attr_reader :name

    def system?
      @node.parent.name == 'system'
    end

    def parent
      raise NotYetImplementedException
    end

    def properties
      raise NotYetImplementedException
    end
  end
end
