FactoryGirl.define do
  factory :ecm_cms_core_folder, :class => Ecm::CmsCore::Folder do
    basename "layouts"

    factory :ecm_cms_core_folder_with_parent do
      association :parent, :factory => :ecm_cms_core_folder
    end
    
    factory :ecm_cms_core_folder_for_home do
      basename "home"
      association :parent, :factory => :ecm_cms_core_folder, :basename => I18n.locale.to_s
    end
  end
end
