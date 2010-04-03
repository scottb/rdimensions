module Dimensions
  module LabeledObject
    attr_reader :labels

    def label
      @labels && @labels[ :label] && @labels[ :label][ :question] && @labels[ :label][ :question][ 'en-US']
    end
  end
end
