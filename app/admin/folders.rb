include CollectiveIdea::Acts::NestedSet::Helper

ActiveAdmin.register Folder do
  form do |f|
    f.inputs do
      f.input :parent, :as => :select, :collection => nested_set_options(Folder, f.object) { |i| "#{'&#160;&#160;&#160;&#160;' * i.level} |--#{i.basename}".html_safe }
      f.input :basename
    end
    f.buttons
  end
  
  index do
    # column :pathname
    # column :basename
    # column :fullname
    column :tree_label
    column :templates_count
    column :created_at
    column :updated_at
    # column :depth
    default_actions
  end
  
  show do |folder|
    attributes_table do
      row :id
      row :parent
      row :basename
      row :pathname
      # row :lgt
      # row :rgt
      # row :depth
      # row :children_count
      row :created_at
      row :updated_at
    end
    
    panel "Templates" do
      table_for folder.templates do
        column :id
        column :filename
        column :partial
        column :created_at
        column :updated_at
      end
    end
    
    active_admin_comments
  end
end
