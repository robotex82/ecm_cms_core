module Ecm
  module CmsCore
    module Generators
      class InstallGenerator < ::Rails::Generators::Base
        desc "Installs the ECM CMS Core module"
        # class_option :skip_migration, :default => false
        class_option :skip_migration, :type => :boolean, :default => false
        
        def generate_migrations
          unless options[:skip_migration]
            generate 'ecm:cms_core:migrations'
          end  
        end
        
#        def generate_models
#          generate 'ecm:cms_core:models'
#        end      
#        
#        def generate_controller
#          generate 'ecm:cms_core:controller'
#        end
#        
#        def generate_locales
#          generate 'ecm:cms_core:locales'
#        end
        
        def generate_active_admin
          generate 'ecm:cms_core:active_admin'
        end          
      end
    end
  end
end

