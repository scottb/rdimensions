require 'mdm/node'
require 'mdm/contextualized'
require 'mdm/text'

module MDM
  class Label < Node
    include Contextualized

    def text_contexts
      text
      @text.keys
    end

    def text_languages( context = 'QUESTION')
      text
      @text[ context].map {|c| c.lang }
    end

    def text( context = 'QUESTION', lang = 'en-US')
      @text ||= instances_for_xpath( 'text', Text).group_by{|t| t.context.upcase }
      @text[ context].find {|text| text.lang.casecmp( lang) }
    end
  end
end
