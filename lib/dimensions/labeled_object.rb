module Dimensions
  module LabeledObject
    def labels
      @labels ||= index_hash( @node.xpath( 'labels').map {|node| Labels.new( @document, node) }) {|label| label.context.downcase.to_sym }
    end

    def label
      labels[ :label][ :question][ 'en-US']
    end

  private
    def index_hash( enum)
      result = {}
      enum.each do |entry|
	result[ yield( entry)] = entry
      end
      result
    end
  end
end
