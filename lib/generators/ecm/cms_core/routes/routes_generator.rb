module Ecm
  module CmsCore
    module Generators
      class RoutesGenerator < Rails::Generators::Base
        desc "Generates the routes"
             
        source_root File.expand_path('../templates', __FILE__)

        def generate_routes
          inject_into_file "config/routes.rb" , :before => "\nend" do
            File.read(File.join(File.dirname(__FILE__), 'templates', 'routes.rb'))
          end
        end  
      end
    end
  end
end        

