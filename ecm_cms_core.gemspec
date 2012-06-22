$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ecm/cms_core/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ecm_cms_core"
  s.version     = Ecm::CmsCore::VERSION
  s.authors     = ["Roberto Vasquez Angel"]
  s.email       = ["roberto@vasquez-angel.de"]
  s.homepage    = "http://blog.robotex.de"
  s.summary     = "Database backed templates and partials."
  s.description = "Database backed templates and partials."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.5"
  s.add_dependency "awesome_nested_set", "~>2.1.2"
  s.add_dependency "i18n_routing", "~>0.6.1"
  s.add_dependency "texterb", "~>0.1.4"

  s.add_development_dependency "sqlite3"
  
  # Server
  s.add_development_dependency "thin"  
  
  # Dummy App
  s.add_development_dependency "activeadmin"
  s.add_development_dependency "sass-rails"
  s.add_development_dependency "meta_search", ">= 1.1.0.pre"
end
