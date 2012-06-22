include CollectiveIdea::Acts::NestedSet::Helper

if defined?(ActiveAdmin)
  ActiveAdmin.register Ecm::CmsCore::Folder do
    menu :label =>  Ecm::CmsCore::Folder.model_name.human(:count => 10), :parent => I18n.t('ecm.cms_core.active_admin.menu')
    
    scope :all
    scope :root_folders

    form do |f|
      f.inputs do
        f.input :parent, :as => :select, :collection => nested_set_options(Ecm::CmsCore::Folder, f.object) { |i| "#{'&#160;&#160;&#160;&#160;' * i.level} |--#{i.basename}".html_safe }
        f.input :basename
      end
      f.buttons
    end
    
    index :title => Ecm::CmsCore::Folder.model_name.human(:count => 10) do
      column :tree_label, :sortable => false
      column :templates_count
      column :created_at
      column :updated_at

      default_actions
    end
    
    show :title => :to_s do |folder|
      attributes_table do
        row :parent
        row :basename
      end
      
      panel Ecm::CmsCore::Template.model_name.human(:count => 10) do
        table_for folder.templates do
          column Ecm::CmsCore::Template.human_attribute_name(:filename), :filename
          column Ecm::CmsCore::Template.human_attribute_name(:partial), :formatted_partial_flag
          column Ecm::CmsCore::Template.human_attribute_name(:created_at), :created_at
          column Ecm::CmsCore::Template.human_attribute_name(:updated_at), :updated_at
          column do |template|
            link_to I18n.t('active_admin.view'), admin_ecm_cms_core_template_path(template), :class => "member_link view_link"
          end        
        end
      end
    end
  end
end  
