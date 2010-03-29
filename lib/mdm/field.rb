require 'mdm/node'

module MDM
  class Field < Node
    has_children :variables, :node_name => 'variable', :class => :Variable
    has_child :mddclass, :node_name => 'class', :class => :MDDClass
  end
end
