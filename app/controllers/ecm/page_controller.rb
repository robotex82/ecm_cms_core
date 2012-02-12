module Ecm
  class PageController < ApplicationController
    include Ecm::CmsCoreHelper
    
    append_view_path ::Template::Resolver.instance
    
    def respond
      @page = params[:page]
      if template = ::Template.where(:pathname => "/#{I18n.locale}/#{params[:page].split("/").reverse.drop(1).reverse.join("/")}/").where(:basename => params[:page].split("/").last).where(:locale => I18n.locale).first
        @meta_description = template.meta_description
        @title = template.title
        layout = template.layout unless template.layout.nil?
      end
       
      if layout 
        render :template => @page, :layout => template.layout
      else  
        render :template => @page
      end  
    end
  end
end      
