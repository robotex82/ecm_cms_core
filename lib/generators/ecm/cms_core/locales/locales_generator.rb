module Ecm
  module CmsCore
    module Generators
      class LocalesGenerator < ::Rails::Generators::Base
        source_root File.expand_path('../templates', __FILE__)
        desc "Installs the needed locales"

        
        def generate_locales
          copy_file "ecm.cms-core.en.yml", "config/locales/ecm.cms-core.en.yml"
          copy_file "ecm.cms-core.de.yml", "config/locales/ecm.cms-core.de.yml"
        end           
      end
    end
  end
end

