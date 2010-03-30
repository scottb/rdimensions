module Dimensions
  class Language < MDMNode
    def xml_name
      node[ 'name']
    end
  end
end
