FactoryGirl.define do
  factory :ecm_cms_core_template, :class => Ecm::CmsCore::Template do
    basename "index"
    locale I18n.locale
    pathname "/"

    factory :ecm_cms_core_template_with_parent do
      association :parent, :factory => :ecm_cms_core_template
    end
    
    factory :ecm_cms_core_template_for_root_page do
      # pathname "de/home/"
      basename "index"
      format "html"
      locale I18n.locale
      handler "erb"
      partial false
      association :folder, :factory => :ecm_cms_core_folder_for_home
    end
  end
end
