require 'spec_helper'

describe "GET /#{I18n.locale}" do
  before do
    @template = FactoryGirl.create(:ecm_cms_core_template_for_root_page, :body => "Hello World!")
  end
  
  it "renders the template content" do
    # get send("root_path")
    get "/#{I18n.locale}"
    response.body.should match @template.body
  end  
  
  it "returns the correct response code" do
    # get send("root_path")
    get "/#{I18n.locale}"
    response.status.should be(200)
  end      
end
