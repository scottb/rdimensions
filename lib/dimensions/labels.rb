module Dimensions
  module Label
    include MDMObject
    attr_reader :context

    def with_context( context)
      @context = context
      self
    end
  end
end
