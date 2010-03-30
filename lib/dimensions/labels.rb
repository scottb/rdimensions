module Dimensions
  class Labels < MDMNode
    include MDMObject

    def context
      node[ 'context']
    end

    def size
      self[ nil]
      @text_nodes.size
    end

    def []( context)
      @text_nodes ||= build_text_index
      @text_nodes[ context]
    end
  private
    def build_text_index
      result = {}
      @node.xpath( 'text').each do |node|
	context = node[ 'context'].downcase.to_sym
	result[ context] ||= {}
	result[ context][ node[ 'lang']] = node.content
      end
      result
    end
  end
end
