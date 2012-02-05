module Ecm
  module CmsCore
    module Generators
      class ModelsGenerator < Rails::Generators::Base
        desc "Generates the models"
             
        source_root File.expand_path('../templates', __FILE__)
      
        def generate_models
          copy_file "folder.rb", "app/models/folder.rb"
          copy_file "template.rb", "app/models/template.rb"
        end      
      end
    end
  end
end        
