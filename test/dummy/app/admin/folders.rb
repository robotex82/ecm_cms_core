include CollectiveIdea::Acts::NestedSet::Helper

ActiveAdmin.register Folder do
  scope :all
  scope :root_folders

  menu :label => I18n.t('activerecord.pluralized_models.folder')

  form do |f|
    f.inputs do
      f.input :parent, :as => :select, :collection => nested_set_options(Folder, f.object) { |i| "#{'&#160;&#160;&#160;&#160;' * i.level} |--#{i.basename}".html_safe }
      f.input :basename
    end
    f.buttons
  end
  
  index :title => I18n.t('activerecord.pluralized_models.folder') do
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
    
    panel I18n.t('activerecord.pluralized_models.template') do
      table_for folder.templates do
        column Template.human_attribute_name(:filename), :filename
        column Template.human_attribute_name(:partial), :formatted_partial_flag
        column Template.human_attribute_name(:created_at), :created_at
        column Template.human_attribute_name(:updated_at), :updated_at
        column do |template|
          link_to I18n.t('active_admin.view'), admin_template_path(template), :class => "member_link view_link"
        end        
      end
    end
  end
end
