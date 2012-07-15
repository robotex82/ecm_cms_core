# workaround, to set default locale for ALL spec
class ActionView::TestCase::TestController
  def default_url_options(options={})
    { :i18n_locale => I18n.locale }
  end
end

class ActionDispatch::Routing::RouteSet
  def default_url_options(options={})
    { :i18n_locale => I18n.locale }
  end
end
