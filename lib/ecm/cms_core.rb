module Ecm
  module CmsCore
    class Engine < Rails::Engine
      config.to_prepare do
        ApplicationController.helper(Ecm::CmsCoreHelper)
      end  
    end
  end  
end
