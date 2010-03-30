module Dimensions
  class Connection < MDMNode
    def name ; @node[ 'name'] ; end
    def dblocation ; @node[ 'dblocation'] ; end
    def cdscname ; @node[ 'cdscname'] ; end
    def project ; @node[ 'project'] ; end
  end
end
