require 'dimensions/node'
require 'dimensions/variable_definition'

module Dimensions
  class VariableDesign < Node
    def definition
      VariableDefinition.new( lookup( @node[ 'ref']), @ids)
    end
  end
end
