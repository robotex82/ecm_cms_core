require 'rake'

namespace :ecm do
  namespace :cms_core_engine do
    desc 'Create home pages for all locales'
    task :create_home_pages => :environment do
      p "Creating pages for locales: #{I18n.available_locales.join(', ')}"
      I18n.available_locales.each do |locale|
        p "Adding home page for locale #{locale}"
        lf = Ecm::CmsCore::Folder.create!(:basename => locale)
        f = Ecm::CmsCore::Folder.create!(:basename => "home", :parent => lf)
        t = f.templates.create!(:basename => 'index',
                                :body => "h1. Home [#{locale}]", 
                                :format => '', 
                                :handler => 'texterb',                                
                                :locale => locale,
                                :partial => false, 
                                :title => "Home [#{locale}]"
        )
        p " -> Created #{t}"
      end  
    end
  end
end
