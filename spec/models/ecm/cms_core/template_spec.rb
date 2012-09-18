require 'spec_helper'

module Ecm
  module CmsCore
    describe Template do
      subject { FactoryGirl.build(:ecm_cms_core_template) }
      
      # associations
      it { should belong_to(:folder) }
      
      # validations
      it { should validate_presence_of(:pathname) }
      it { should validate_presence_of(:basename) }
      
      it "should only accept available locales" do
        template = FactoryGirl.build(:ecm_cms_core_template, :locale => 'invalid')
        template.should_not be_valid      
      end 
#      
#      # acts as list
#      it { should respond_to(:move_higher) }
#      
#      # friendly id
#      it "should have a friendly id" do
#        download = FactoryGirl.create(:ecm_downloads_download, :name => 'This is a download that should have a friendly id!')
#        download.to_param.should == 'this-is-a-download-that-should-have-a-friendly-id'
#      end 
#      
#      # methods
    end
  end
end    
    
