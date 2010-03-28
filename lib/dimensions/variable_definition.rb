require 'dimensions/node'
require 'dimensions/labeled'

module Dimensions
  class VariableDefinition < Node
    include Labeled
    has_children :category_set, :node_name => 'category', :class => :CategoryDefinition
    has_child :helperfields, :class => :HelperFields

    def type
      case @node[ 'type']
      when '0'
	:static
      when '1'
	:integer
      when '2'
	:text
      when '3'
	:category
      when '5'
	:date
      else
	@node[ 'type'].to_i
      end
    end

    def casedata?
      !@node.has_attribute?( 'no-casedata') || @node[ 'no-casedata'] != '-1'
    end
  end
end
