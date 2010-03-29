require 'mdm/node'
require 'mdm/labeled'

module MDM
  class CategoryDefinition < Node
    include Labeled
    has_children :categories, :node_name => 'category', :class => :Category
  end
end
