require 'mdm/node'
require 'mdm/labeled'

module MDM
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
