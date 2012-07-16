module Ecm::CmsCoreHelper
  def cms_body_classes
    url_for().gsub("/", " ").strip!
  end
  
  def cms_page_stylesheets(namespace = nil)
    output = ""
    if namespace
      namespace_string = "#{namespace}/"
    else
      namespace_string = ""
    end
    url_for().split("/").each do |path_part|
      output << stylesheet_link_tag("#{namespace_string}#{path_part}.css", :media => 'screen') unless path_part.blank? || path_part.length == 1
    end
    output.html_safe
  end      
  
  # Displays the site title 
  def cms_title(site_title = nil)
    site_title ||= Rails.application.class.to_s.split("::").first.titleize
    return "#{site_title} - #{@title}" if @title
    site_title
  end
  
  def cms_meta_description
    @meta_description
  end  
  
  def cms_meta_description_tag
    "<meta name=\"description\" content=\"#{cms_meta_description}\" />".html_safe
  end
  
  def render_fragment(name)
    if controller_name == 'page'
      page = (params[:page].nil?) ? "home" : params[:page]
    else
      page = request.fullpath.gsub(/\/#{I18n.locale}\//, '')
    end  
    
    path = "#{name.to_s}/#{page}"
    full_path = "#{I18n.locale}/#{path}"

    begin 
      render path
    rescue ActionView::MissingTemplate => e
      if Rails.env.production?
        return nil
      else 
        return I18n.t("ecm.cms_core.warnings.missing_fragment", :name => full_path)
      end        
    end  
  end
end
