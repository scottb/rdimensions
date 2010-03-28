require 'dimensions/node'
require 'dimensions/labeled'

module Dimensions
  class Categories < Node
    include Labeled
    has_children :category_set, :node_name => 'category', :class => :CategoryDefinition
    has_children :categories, :class => :Categories

    def categoriesref
      ref = lookup( node[ 'categoriesref'])
      ref ? Categories.new( ref, @ids) : nil
    end
  end
end
