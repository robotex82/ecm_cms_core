class FrontendController < ApplicationController
  include ::I18nController
  
  before_filter :set_locale
end
