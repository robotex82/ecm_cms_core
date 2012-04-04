class CreateTemplates < ActiveRecord::Migration
  def self.up
    create_table :ecm_cms_core_templates do |t|
      t.references :folder
      t.string :pathname
      t.string :basename
      t.string :title
      t.text :meta_description
      t.text :body
      t.string :layout
      t.string :locale
      t.string :format
      t.string :handler
      t.boolean :partial, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :ecm_cms_core_templates
  end
end
