module Ecm
  module CmsCore
    module Generators
      class ActiveAdminGenerator < Rails::Generators::Base
        desc "Generates the active admin files"
             
        source_root File.expand_path('../templates', __FILE__)
      
        def generate_models
          copy_file "folders.rb", "app/admin/folders.rb"
          copy_file "templates.rb", "app/admin/templates.rb"
        end      
      end
    end
  end
end        
