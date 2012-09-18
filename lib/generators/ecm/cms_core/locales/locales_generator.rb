module Ecm
  module CmsCore
    module Generators
      class LocalesGenerator < ::Rails::Generators::Base
        source_root File.expand_path('../../../../../../config/locales', __FILE__)
        desc "Installs the needed locales"

        
        def generate_locales
          copy_file "ecm.cms_core.en.yml", "config/locales/ecm.cms_core.en.yml"
          copy_file "ecm.cms_core.forms.en.yml", "config/locales/ecm.cms_core.forms.en.yml"
          copy_file "ecm.cms_core.folder.en.yml", "config/locales/ecm.cms_core.folder.en.yml"
          copy_file "ecm.cms_core.template.en.yml", "config/locales/ecm.cms_core.template.en.yml"
          
          copy_file "ecm.cms_core.de.yml", "config/locales/ecm.cms_core.de.yml"
          copy_file "ecm.cms_core.forms.de.yml", "config/locales/ecm.cms_core.forms.de.yml"
          copy_file "ecm.cms_core.folder.de.yml", "config/locales/ecm.cms_core.folder.de.yml"
          copy_file "ecm.cms_core.template.de.yml", "config/locales/ecm.cms_core.template.de.yml"
        end           
      end
    end
  end
end

