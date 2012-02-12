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
      
      begin 
        if layout 
          render :template => @page, :layout => template.layout
        else  
          render :template => @page
        end  
      rescue ActionView::MissingTemplate
        render_404
      end  
    end
    
    def render_404
      respond_to do |format|
        format.html { render :file => "#{Rails.root}/public/404.html", :status => :not_found }
        format.xml  { head :not_found }
        format.any  { head :not_found }
      end
    end

  end
end      
