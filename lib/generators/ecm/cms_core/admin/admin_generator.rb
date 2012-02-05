module Ecm
  module CmsCore
    module Generators
      class AdminGenerator < Rails::Generators::Base
        desc "Generates the active admin files"
             
        source_root File.expand_path('../../../../app/', __FILE__)
      
        def generate_models
          copy_file "admin/folders.rb", "app/admin/folders.rb"
          copy_file "admin/templates.rb", "app/admin/templates.rb"
        end      
      end
    end
  end
end        
