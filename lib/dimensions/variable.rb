module Dimensions
  class Variable < Field
    def has_case_data?
      !( @node.has_attribute?( 'no-casedata') && node[ 'no-casedata'] == '-1')
    end
  end
end
