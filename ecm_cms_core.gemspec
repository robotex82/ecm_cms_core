$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ecm/cms_core/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ECM CMS Core"
  s.version     = Ecm::CmsCore::VERSION
  s.authors     = ["Roberto Vasquez Angel"]
  s.email       = ["roberto@vasquez-angel.de"]
  s.homepage    = "http://blog.robotex.de"
  s.summary     = "TODO: Summary of EcmCmsCore."
  s.description = "TODO: Description of EcmCmsCore."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.3"
  s.add_dependency("awesome_nested_set")

  s.add_development_dependency "sqlite3"
end
