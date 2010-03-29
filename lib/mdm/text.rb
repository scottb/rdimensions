require 'mdm/node'
require 'mdm/contextualized'

module MDM
  class Text < Node # has only @context, @lang, and contents
    include Contextualized

    def value
      node.content
    end

    def to_s
      value
    end
  end
end
