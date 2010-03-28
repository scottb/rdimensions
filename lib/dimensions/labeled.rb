require 'dimensions/label'

module Dimensions
  module Labeled
    def labels_present?
      labels
      @labels.size > 0
    end

    def label_contexts
      labels
      @labels.keys
    end

    def label
      labels.first
    end

    def labels( context = 'LABEL')
      @labels ||= instances_for_xpath( 'labels', Label).group_by {|l| l.context.upcase }
      @labels[ context]
    end
  end
end
