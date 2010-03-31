module Dimensions
  module LabeledObject
    attr_accessor :labels

    def label
      @labels[ :label][ :question][ 'en-US']
    end
  end
end
