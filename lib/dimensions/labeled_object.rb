module Dimensions
  module LabeledObject
    attr_reader :labels

    def label
      @labels[ :label][ :question][ 'en-US']
    end
  end
end
