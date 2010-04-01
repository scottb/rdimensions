$LOAD_PATH << 'lib'

require 'dimensions'

@dataset = Dimensions::Document.read( 'spec/fixtures/P4550054.mdd')
@dataset.variable_instances
=begin
WARNING: Nokogiri was built against LibXML version 2.6.32, but has dynamically loaded 2.7.5
=end
