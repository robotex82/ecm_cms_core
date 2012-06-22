
#  localized(I18n.available_locales, :verbose => true) do
#    scope "/:i18n_locale", :constraints => {:i18n_locale => /#{I18n.available_locales.join('|')}/} do 
#    
#      # match '/' => "page#respond", :page => '/home/index', :as => :root
#      root :to => "home#index", :i18n_locale => I18n.locale, :to => "page#respond", :page => '/home/index'
#      match "/*page", :to => "page#respond", :as => :page
#    end  
#  end  
#  match "/", :to => redirect("/#{I18n.locale}")

 match "/*page", :to => "page#respond", :as => :page
 # match '/' => "page#respond", :page => 'home/index', :as => :root
 root :to => "home#index", :to => "page#respond", :page => '/home/index'
