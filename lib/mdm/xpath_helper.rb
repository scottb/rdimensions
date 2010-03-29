require 'mdm/node'

module MDM
  module XpathHelper
    attr_accessor :node

    def instances_for_xpath( path, klass)
      @node.xpath( path).map {|n| klass.new( n, @ids) }
    end

    def lookup( id)
      @ids[ id]
    end

    def immediate_children
      @node.children.map( &:name)
    end

    def _nodes( path)
      instances_for_xpath( path, Node)
    end
  end
end
