module Ecm
  module CmsCore
    module Generators
      class ModelsGenerator < Rails::Generators::Base
        desc "Generates the models"
             
        source_root File.expand_path('../../../../app/', __FILE__)
      
        def generate_models
          copy_file "models/folder.rb", "app/models/folder.rb"
          copy_file "models/template.rb", "app/models/template.rb"
        end      
      end
    end
  end
end        
