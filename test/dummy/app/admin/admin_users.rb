ActiveAdmin.register AdminUser do
  filter :email

  index do
    selectable_column
    column :email
    column :last_sign_in_at
    column :created_at
    column :sign_in_count    
    default_actions
  end

  show :title => :email do
    attributes_table do
      row :email
      row :last_sign_in_at
      row :last_sign_in_ip
      row :created_at
      row :sign_in_count
    end
    active_admin_comments
  end

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.buttons
  end
end
