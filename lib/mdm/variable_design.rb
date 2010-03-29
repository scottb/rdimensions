require 'mdm/node'
require 'mdm/variable_definition'

module MDM
  class VariableDesign < Node
    def definition
      VariableDefinition.new( lookup( @node[ 'ref']), @ids)
    end
  end
end
