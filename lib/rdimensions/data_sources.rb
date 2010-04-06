module RDimensions
  module DataSources
    attr_accessor :default
    attr_writer :current

    def current
      @current || @default
    end

    def with_default( value)
      @default = value
      self
    end
  end
end
