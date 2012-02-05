module Ecm
  module CmsCore
    module Generators
      class InstallGenerator < ::Rails::Generators::Base
        include Rails::Generators::Migration
        # source_root File.expand_path('../templates', __FILE__)
        desc "Installs the ECM CMS Core module"

        def generate_active_admin
          generate 'ecm:cms_core:active_admin'
        end              
        
        def generate_controller
          generate 'ecm:cms_core:controller'
        end
        
        def generate_locales
          generate 'ecm:cms_core:locales'
        end
        
        def generate_active_admin
          generate 'ecm:cms_core:migrations'
        end
        
        def generate_active_admin
          generate 'ecm:cms_core:models'
        end
      end
    end
  end
end

