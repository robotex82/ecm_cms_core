class PageController < ApplicationController
  append_view_path Template::Resolver.instance
  
  def respond
    @page = params[:page]
    render :template => @page
  end
end    
