$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "catscan/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name             = "catscan"
  spec.version          = Catscan::VERSION
  spec.authors       = ["Michael de Silva"]
  spec.email         = ["michael@mwdesilva.com"]
  spec.homepage      = "http://mwdesilva.com"
  spec.summary       = "A"
  spec.description   = spec.summary
  spec.license       = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]

  spec.required_ruby_version = '>= 1.9.3'

  spec.add_dependency "rails", "~> 3.2.15"
  # s.add_dependency "jquery-rails"

  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rspec-rails", "~> 2.0"
  spec.add_development_dependency "mocha"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "yard"
  spec.add_development_dependency "nyan-cat-formatter"
end
