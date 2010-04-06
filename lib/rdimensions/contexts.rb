module RDimensions
  module Contexts
    attr_reader :base
    attr_writer :current

    def current
      @current || base
    end

    def with_base( s)
      @base = s
      self
    end
  end
end
