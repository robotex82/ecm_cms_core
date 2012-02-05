module Ecm
  module CmsCore
    module Generators
      class ControllerGenerator < Rails::Generators::Base
        desc "Generates the pages controller"
             
        source_root File.expand_path('../templates', __FILE__)
      
        def generate_controller
          copy_file "page_controller.rb", "app/controllers/page_controller.rb"
        end      
      end
    end
  end
end        
