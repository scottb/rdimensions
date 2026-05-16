Gem::Specification.new do |s|
  s.name = "rdimensions"
  s.version = "0.3.0"

  s.authors = ["Scott Brickner"]
  s.email = "scottb@brickner.net"
  s.summary = "Dimensions Metadata"
  s.description = "Rudimentary access to Dimensions Metadata"
  s.license = nil

  s.files = Dir["lib/**/*"]

  s.homepage = "http://github.com/scottb/rdimensions"
  s.required_ruby_version = ">= 3.0"

  s.add_dependency "nokogiri", "~> 1.4"

  s.metadata["rubygems_mfa_required"] = "true"
end
