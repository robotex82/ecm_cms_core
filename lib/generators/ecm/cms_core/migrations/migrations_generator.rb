require 'rails/generators/migration'

module Ecm
  module CmsCore
    module Generators
      class MigrationsGenerator < ::Rails::Generators::Base
        include Rails::Generators::Migration
        source_root File.expand_path('../templates', __FILE__)
        desc "Installs the needed migrations"

        def self.next_migration_number(path)
          unless @prev_migration_nr
            @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
          else
            @prev_migration_nr += 1
          end
          @prev_migration_nr.to_s
        end

        def copy_migrations
          migration_template "create_folders.rb", "db/migrate/create_folders.rb"
          migration_template "create_templates.rb", "db/migrate/create_templates.rb"
        end         
      end
    end
  end
end

