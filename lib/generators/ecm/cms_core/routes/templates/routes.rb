
#  localized(I18n.available_locales, :verbose => true) do
#    scope "/:i18n_locale", :constraints => {:i18n_locale => /#{I18n.available_locales.join('|')}/} do 
#    
#      match '/' => "ecm/cms_core/page#respond", :page => '/home/index', :as => :root
#      match "/*page", :to => "ecm/cms_core/page#respond", :as => :page
#    end  
#  end  
#  match "/", :to => redirect("/#{I18n.locale}")

 match "/*page", :to => "ecm/cms_core/page#respond", :as => :page
 match '/' => "ecm/cms_core/page#respond", :page => 'home/index', :as => :root
