require 'dimensions/node'
require 'dimensions/variable_definition'

module Dimensions
  class Variable < Node
    def ref
      VariableDefinition.new( lookup( node[ 'ref']), @ids)
    end
  end
end
