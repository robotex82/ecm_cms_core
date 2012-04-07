class CreateEcmCmsCoreFolders < ActiveRecord::Migration
  def self.up
    create_table :ecm_cms_core_folders do |t|
      t.references :parent
      t.string :basename
      t.string :pathname
      t.integer :lft
      t.integer :rgt
      t.integer :depth
      t.integer :children_count, :default => 0
      t.integer :templates_count, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :ecm_cms_core_folders
  end
end
