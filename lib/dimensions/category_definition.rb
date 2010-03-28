require 'dimensions/node'
require 'dimensions/labeled'

module Dimensions
  class CategoryDefinition < Node
    include Labeled
    has_children :categories, :node_name => 'category', :class => :Category
  end
end
