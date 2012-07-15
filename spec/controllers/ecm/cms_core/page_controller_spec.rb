require 'spec_helper'

module Ecm
  module CmsCore
    describe PageController do
      render_views
      
      describe "GET respond for the home page" do
        before do
          @template = FactoryGirl.create(:ecm_cms_core_template_for_root_page, :body => "Hello World!")
        end

        it "renders the home page" do
          get :respond, :page => 'home/index', :i18n_locale => I18n.locale
          response.body.should match @template.body
        end
        
        it "returns the correct response code" do
          get :respond, :page => 'home/index', :i18n_locale => I18n.locale
          response.status.should be(200)
        end
      end
    end
  end
end
