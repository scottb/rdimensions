require 'mdm/node'

module MDM
  class HelperFields < Node
    has_child :mddclass, :node_name => 'class', :class => :MDDClass
    has_children :variables, :node_name => 'variable', :class => :Variable
  end
end
