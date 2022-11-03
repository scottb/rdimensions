module RDimensions
  module LabeledObject
    attr_reader :labels

    def label
      if @labels && @labels.has_key?( :label)
	lbl = @labels[ :label]
	context = document.default_label_context
	if lbl.has_key? context
	  lbl = lbl[ context]
	else
	  lbl = lbl[ :question]
	end
        lbl ||= {}
	language = document.default_label_language
	if lbl.has_key? language
	  lbl[ language]
	else
	  lbl[ 'en-US']
	end
      end
    end
  end
end
