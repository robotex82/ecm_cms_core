source "http://rubygems.org"

# Declare your gem's dependencies in ecm_cms_core.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# jquery-rails is used by the dummy application
gem "jquery-rails"

# awesome_nested_set used by the dummy application
gem "awesome_nested_set"
gem "i18n_routing"

gem 'activeadmin', :git => 'git://github.com/gregbell/active_admin.git'
gem 'ecm_admin', :git => 'git://github.com/robotex82/ecm_admin.git', :branch => 'rails-3-2-active-admin'

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer'

  gem 'uglifier', '>= 1.0.3'
end
