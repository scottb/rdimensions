P4550054 = File.expand_path( File.dirname(__FILE__) + '/fixtures/P4550054.mdd')

require 'dimensions'

Spec::Matchers.define :have_case_data do
  match {|field| field.has_case_data? }
end
