require 'mdm/node'
require 'mdm/labeled'
require 'mdm/variable_definition'

module MDM
  class LoopDesign < Node
    include Labeled
    has_children :categories, :class => :Categories
    has_child :mddclass, :node_name => 'class', :class => :MDDClass

    def definition
      @definition = VariableDefinition.new( lookup( @node[ 'ref']), @ids)
    end

    def iteration_names
      categories.first.category_set.map {|c| "#{name}[{#{c.name}}]" }
    end

    def iteration_class_names
      field = mddclass.field
      path = []
      until field.variables_present?
	path << field.mddclass.name
	field = field.mddclass.field
      end
      variables = field.variables
      names = variables.map( &:name)
      variables.map do |v|
	names += v.ref.helperfields.variables.map {|vref| "#{v.name}.#{vref.name}" } unless v.ref.helperfields.mddclass.nil?
      end
      path.empty? ? names : path.product( names).map {|x| x.join( ".") }
    end
  end
end
