module RDimensions
  module LabeledObject
    attr_reader :labels

    def label
      if @labels && @labels.has_key?( :label)
	label = @labels[ :label]
	context = document.default_label_context
	if label.has_key? context
	  label = label[ context]
	else
	  label = label[ :question]
	end
	language = document.default_label_language
	if label.has_key? language
	  label[ language]
	else
	  label[ 'en-US']
	end
      end
    end
  end
end
