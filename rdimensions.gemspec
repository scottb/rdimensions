# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rdimensions}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Scott Brickner"]
  s.date = %q{2010-04-06}
  s.description = %q{Rudimentary access to Dimensions Metadata}
  s.email = %q{scottb@brickner.net}
  s.extra_rdoc_files = [
    "README"
  ]
  s.files = [
    "README",
     "VERSION",
     "hack.rb",
     "lib/rdimensions.rb",
     "lib/rdimensions/categories.rb",
     "lib/rdimensions/connection.rb",
     "lib/rdimensions/context.rb",
     "lib/rdimensions/contexts.rb",
     "lib/rdimensions/data_sources.rb",
     "lib/rdimensions/document.rb",
     "lib/rdimensions/exceptions.rb",
     "lib/rdimensions/field.rb",
     "lib/rdimensions/label.rb",
     "lib/rdimensions/labeled_object.rb",
     "lib/rdimensions/language.rb",
     "lib/rdimensions/mdm_array.rb",
     "lib/rdimensions/mdm_class.rb",
     "lib/rdimensions/mdm_element.rb",
     "lib/rdimensions/mdm_node.rb",
     "lib/rdimensions/mdm_object.rb",
     "lib/rdimensions/reader.rb",
     "lib/rdimensions/variable.rb",
     "lib/rdimensions/variable_instance.rb",
     "spec/fixtures/P4550054.mdd",
     "spec/rdimensions/document_spec.rb",
     "spec/rdimensions/labeled_object_spec.rb",
     "spec/rdimensions/mdm_array_spec.rb",
     "spec/rdimensions/reader_spec.rb",
     "spec/rdimensions/variable_instance_spec.rb",
     "spec/rdimensions/variable_spec.rb",
     "spec/spec.opts",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/scottb/rdimensions}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Rudimentary access to Dimensions Metadata}
  s.test_files = [
    "spec/spec_helper.rb",
     "spec/rdimensions/reader_spec.rb",
     "spec/rdimensions/variable_spec.rb",
     "spec/rdimensions/variable_instance_spec.rb",
     "spec/rdimensions/mdm_array_spec.rb",
     "spec/rdimensions/labeled_object_spec.rb",
     "spec/rdimensions/document_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
