module Dimensions
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

    def self.build_contexts_for( path, owner, document = owner.document)
      owner.node.xpath( "#{path}/context").map {|node| Context.new( document, node) }.extend( Contexts).with_base( owner.node.at( "#{path}/@base").value)
    end
  end
end
