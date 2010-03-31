$LOAD_PATH << 'lib'

require 'dimensions'

def check_ref( ref)
  @dataset.lookup( ref).path
end

@dataset = Dimensions::Document.read( 'spec/fixtures/P4550054.mdd')
=begin

=end
