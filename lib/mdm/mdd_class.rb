require 'mdm/node'

module MDM
  class MDDClass < Node
    has_child :field, :node_name => 'fields', :class => :Field
  end
end
