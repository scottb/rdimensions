module Dimensions
  module MDMObject
    attr_reader :document
    attr_reader :uuid
    attr_reader :name

    def reference?
      !@node[ 'ref'].nil?
    end

    def system?
      @node.parent.name == 'system'
    end

    def parent
      raise NoteYetImplementedException
    end

    def properties
      raise NoteYetImplementedException
    end
  end
end
