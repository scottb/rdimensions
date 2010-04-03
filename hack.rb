$LOAD_PATH << 'lib'

require 'dimensions'

@dataset = Dimensions::Document.read( 'spec/fixtures/P4550054.mdd')
p @dataset.variable_instances.map( &:name)
=begin
=end
