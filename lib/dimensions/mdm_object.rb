module Dimensions
  module MDMObject
    def self.node_attr_reader( name, options = {})
      attr_name = ( options[ :attr] || name).to_s
      define_method( name) do
	node[ attr_name]
      end
    end

    attr_reader :document
    node_attr_reader :name
    node_attr_reader :uuid, :attr => :id

    def reference?
      !@node[ 'ref'].nil?
    end

    def system?
      @node.parent.name == 'system'
    end

    def object_type_value
    end

    def parent
      raise NotYetImplemented
    end

    def properties
      raise NotYetImplemented
    end
  end
end
