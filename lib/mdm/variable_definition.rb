require 'mdm/node'
require 'mdm/labeled'

module MDM
  class VariableDefinition < Node
    include Labeled
    has_children :category_set, :node_name => 'category', :class => :CategoryDefinition
    has_child :helperfields, :class => :HelperFields

    # from docs:
    # mtNone = 0
    # mtDouble = 6
    # mtLong = 1
    # mtText = 2
    # mtCategorical = 3
    # mtObject = 4
    # mtDate = 5
    # mtBoolean = 7
    # mtLevel = 8
    def type
      case @node[ 'type']
      when '0'
	:none
      when '1'
	:integer
      when '2'
	:text
      when '3'
	:category
      when '4'
	:object
      when '5'
	:date
      when '6'
	:double
      when '7'
	:boolean
      when '8'
	:level
      else
	@node[ 'type'].to_i
      end
    end

    def casedata?
      !@node.has_attribute?( 'no-casedata') || @node[ 'no-casedata'] != '-1'
    end
  end
end
