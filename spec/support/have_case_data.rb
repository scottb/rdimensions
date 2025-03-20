RSpec::Matchers.define :have_case_data do
  match(&:has_case_data?)
end
