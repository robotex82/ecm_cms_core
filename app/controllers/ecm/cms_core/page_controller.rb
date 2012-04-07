module Ecm
  module CmsCore
    class PageController < ::FrontendController
      include Ecm::CmsCoreHelper
      
      append_view_path Template::Resolver.instance
      
      def render_404
        respond_to do |format|
          format.html { render :file => "#{Rails.root}/public/404.html", :status => :not_found, :layout => nil }
          format.xml  { head :not_found }
          format.any  { head :not_found }
        end
      end
      
      def respond
        page, pathname, basename = extract_names_from_params
        
        if template = Template.where(:pathname => pathname).where(:basename => basename).where(:locale => I18n.locale).first
          @meta_description = template.meta_description
          @title = template.title
          layout = template.layout unless template.layout.nil?
        end
        
        begin 
          if layout.respond_to?(:length) && layout.length > 0
            render :template => page, :layout => template.layout
          else  
            render :template => page
          end  
        rescue ActionView::MissingTemplate
          render_404
        end 
        return 
      end
      
      def extract_names_from_params
        page = params[:page]
        page ||= "/home/index"
        pathname = "#{I18n.locale}"
        
        subpath = page.split("/").reverse.drop(1).reverse.join("/").sub(/(\/)+$/,'')
        if subpath.length > 0
          pathname << "#{subpath}"
        end
        pathname << '/' unless pathname.end_with?('/')
        basename = page.split("/").last
        logger.debug("pathname: #{pathname}")
        logger.debug("basename: #{basename}")
        return page, pathname, basename
      end 
    end
  end
end  
  
