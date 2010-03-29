require 'mdm/xpath_helper'

module MDM
  class Node
    include XpathHelper
    def initialize( node, ids)
      @node, @ids = node, ids
    end

    def ==( other)
      return @other.is_a?( Node) && @node.equal?( other.node)
    end

    def to_s
      node.to_s
    end

    def inspect
      "<#{self.class.name}>"
    end

    def self.has_child( symbol, options = {})
      node_name, class_name, instance_variable_name = parse_has_options( symbol, options)
      eval %Q{def #{symbol}
	#{instance_variable_name} ||= instances_for_xpath( "#{node_name}", #{class_name}).first
      end}
    end

    def self.has_children( symbol, options = {})
      node_name, class_name, instance_variable_name = parse_has_options( symbol, options)
      eval %Q{def #{symbol}_present?
	!#{symbol}.empty?
      end

      def #{symbol}
	#{instance_variable_name} ||= instances_for_xpath( "#{node_name}", #{class_name})
      end}
    end

  private
    def self.parse_has_options( symbol, options)
      node_name = options[ :node_name] || symbol.to_s
      class_name = options[ :class] || symbol.to_s.capitalize
      instance_variable_name = "@#{symbol}"
      [ node_name, class_name, instance_variable_name ]
    end

    def method_missing( symbol, *args, &block)
      name = symbol.to_s
      return @node[ name] if @node.has_attribute?( name)
      super
    end
  end
end
