class CreateTemplates < ActiveRecord::Migration
  def self.up
    create_table :templates do |t|
      t.references :folder
      t.string :pathname
      t.string :basename
      t.text :body
      t.string :locale
      t.string :format
      t.string :handler
      t.boolean :partial, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :templates
  end
end
