require 'rails/generators/migration'

module Ecm
  module CmsCore
    module Generators
      class InstallGenerator < ::Rails::Generators::Base
        include Rails::Generators::Migration
        source_root File.expand_path('../templates', __FILE__)
        desc "Installs the needed locales and migrations"

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
        
        def generate_locales
          copy_file "ecm.cms-core.en.yml", "config/locales/ecm.cms-core.en.yml"
          copy_file "ecm.cms-core.de.yml", "config/locales/ecm.cms-core.de.yml"
        end           
      end
    end
  end
end

