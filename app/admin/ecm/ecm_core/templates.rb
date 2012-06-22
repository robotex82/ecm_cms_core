if defined?(ActiveAdmin)
  ActiveAdmin.register Ecm::CmsCore::Template do
    menu :label => Ecm::CmsCore::Template.model_name.human(:count => :other), :parent => I18n.t('ecm.cms_core.active_admin.menu')
    
    scope :all
    scope :templates
    scope :partials
    
    
    form do |f|
      f.inputs do
        f.input :folder, :as => :select, :collection => nested_set_options(Ecm::CmsCore::Folder) { |i| "#{'&#160;&#160;&#160;&#160;' * i.level} |--#{i.basename}".html_safe }
        f.input :basename
        f.input :title
        f.input :meta_description
        f.input :body
        f.input :locale,  :as => :select, :collection => I18n.available_locales.map(&:to_s)  
      end  
     # f.inputs I18n.t("active_admin.forms.sections.#{resource.class.to_s.tableize.gsub('::', '/')}.advanced") do
      f.inputs :"ecm/cms_core/template.advanced" do    
        f.input :layout
        f.input :format,  :as => :select, :collection => Mime::SET.symbols.map(&:to_s)
        f.input :handler, :as => :select, :collection => ActionView::Template::Handlers.extensions.map(&:to_s)
        f.input :partial
      end
      f.buttons
    end
    
    index :title => Ecm::CmsCore::Template.model_name.human(:count => 10) do
      column :folder, :sortable => :pathname
      column :filename, :sortable => :basename
      column :formatted_partial_flag, :sortable => :partial
      column :created_at
      column :updated_at
      
      default_actions
    end
    
    show :title => :to_s do
      attributes_table do
        row :folder
        row :filename
        row :title
        row :meta_description
        row :formatted_partial_flag
        row :created_at
        row :updated_at
      end
      
      panel Ecm::CmsCore::Template.human_attribute_name(:body) do
        div do
          textilize(ecm_cms_core_template.body).html_safe
        end
      end
    end
  end
end  
