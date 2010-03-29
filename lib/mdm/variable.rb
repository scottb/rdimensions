require 'mdm/node'
require 'mdm/variable_definition'

module MDM
  class Variable < Node
    def ref
      VariableDefinition.new( lookup( node[ 'ref']), @ids)
    end
  end
end
