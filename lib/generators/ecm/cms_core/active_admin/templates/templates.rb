ActiveAdmin.register Template do
  form do |f|
    f.inputs do
      f.input :folder, :as => :select, :collection => nested_set_options(Folder) { |i| "#{'&#160;&#160;&#160;&#160;' * i.level} |--#{i.basename}".html_safe }
      f.input :basename
      f.input :body
      f.input :locale,  :as => :select, :collection => I18n.available_locales.map(&:to_s)  
      f.input :format,  :as => :select, :collection => Mime::SET.symbols.map(&:to_s)
      f.input :handler, :as => :select, :collection => ActionView::Template::Handlers.extensions.map(&:to_s)
      f.input :partial
    end
    f.buttons
  end
  
  index do
    column :id
    column :folder
    column :filename
    column :partial
    column :created_at
    column :updated_at
    
    default_actions
  end
end
