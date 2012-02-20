ActiveAdmin.register Template do
  menu :label => I18n.t('activerecord.pluralized_models.template')
  
  scope :all
  scope :templates
  scope :partials
  
  
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
  
  index :title => I18n.t('activerecord.pluralized_models.template') do
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
      row :formatted_partial_flag
      row :created_at
      row :updated_at
    end
    
    panel Template.human_attribute_name(:body) do
      div do
        template.body
      end
    end
  end
end
