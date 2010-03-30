module Dimensions
  module DataSources
    attr_accessor :default

    def with_default( value)
      @default = value
      self
    end
  end
end
