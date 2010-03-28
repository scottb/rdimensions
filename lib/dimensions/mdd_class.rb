require 'dimensions/node'

module Dimensions
  class MDDClass < Node
    has_child :field, :node_name => 'fields', :class => :Field
  end
end
