module Dimensions
  class Field < MDMNode
    include MDMObject
    include LabeledObject

    def data_type
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

    def categories
      @categories ||= @node.xpath( 'categories/category').map {|node| MDMElement.new( @document, node) }
    end
  end
end
