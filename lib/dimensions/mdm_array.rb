module Dimensions
  class MDMArray < Field
    def name_prefix
      "#{name}[..]."
    end
  end
end
