module Ecm
  module CmsCore
    class Template < ActiveRecord::Base
      self.table_name = 'ecm_cms_core_templates'
      
      belongs_to :folder, :counter_cache => true
      
      validates :pathname, :presence => true
      validates :basename, :presence => true, :uniqueness => { :scope => :folder_id }
      validates :format,  :inclusion => ::Mime::SET.symbols.map(&:to_s), :allow_nil => true, :allow_blank => true
      validates :locale,  :inclusion => ::I18n.available_locales.map(&:to_s)
      validates :handler, :inclusion => ::ActionView::Template::Handlers.extensions.map(&:to_s)
      
      after_initialize :set_defaults
      
      before_validation :update_pathname
      
      attr_accessible :folder_id, :basename, :title, :meta_description, :body, :layout, :locale, :format, :handler, :partial
      
      def set_defaults
        unless self.persisted?
          self.locale  ||= I18n.default_locale
          self.format  ||= 'html'
          self.handler ||= 'texterb'
        end
      end
      
      def update_pathname
        self.pathname = self.folder.fullname unless self.folder.blank?
      end
      
      def update_pathname!
        self.update_pathname
        self.save!
      end
      
      after_save do
        Resolver.instance.clear_cache
      end
      
      def self.partials
        where("partial = ?", true)
      end  
      
      def self.templates
        where("partial = ?", false)
      end  
      
      def filename
        if format.blank?
        "#{basename}.#{locale}.#{handler}"
        else    
          "#{basename}.#{locale}.#{format}.#{handler}"
        end
      end  
      
      def formatted_partial_flag
        ::I18n.t(self.partial.to_s)
      end
      
      def to_s
        "#{self.pathname}#{self.basename}"
      end

      class Resolver < ActionView::Resolver
        require "singleton"
        include Singleton

        def find_templates(name, prefix, partial, details)
          if prefix.length > 0
            pathname = "#{normalize_array(details[:locale]).first}/#{prefix}/"
          else
            pathname = "#{normalize_array(details[:locale]).first}/"
          end  
          

          # ActiveRecord::Base.logger.debug("prefix: #{prefix}")
          ActiveRecord::Base.logger.debug("pathname: #{pathname}")
          ActiveRecord::Base.logger.debug("basename: #{name}")          
        
          conditions = {
            # :pathname    => normalize_path(name, prefix),
            :pathname    => pathname,
            :basename    => name,
            :locale      => normalize_array(details[:locale]).first,
            :format      => normalize_array(details[:formats]).first,
            :handler     => normalize_array(details[:handlers]),
            :partial     => partial || false
          }

          format = conditions.delete(:format)
          query  = Ecm::CmsCore::Template.where(conditions)

          # 2) Check for templates with the given format or format is nil
          query = query.where(["format = ? OR format = ''", format])

          # 3) Ensure templates with format come first
          query = query.order("format DESC")

          # 4) Now trigger the query passing on conditions to initialization
          query.map do |record|
            initialize_template(record, details)
          end
        end

        # Normalize name and prefix, so the tuple ["index", "users"] becomes
        # "users/index" and the tuple ["template", nil] becomes "template".
        def normalize_path(name, prefix)
          prefix.present? ? "#{prefix}/#{name}" : name
        end

        # Normalize arrays by converting all symbols to strings.
        def normalize_array(array)
          array.map(&:to_s)
        end

        # Initialize an ActionView::Template object based on the record found.
        def initialize_template(record, details)
          source     = record.body
          identifier = "Template - #{record.id} - #{record.pathname.inspect}"
          handler    = ::ActionView::Template.registered_template_handler(record.handler)

          # 5) Check for the record.format, if none is given, try the template
          # handler format and fallback to the one given on conditions
          format   = record.format && Mime[record.format]
          format ||= handler.default_format if handler.respond_to?(:default_format)
          format ||= details[:formats]

          details = {
            :format => format,
            :updated_at => record.updated_at,
            :virtual_path => virtual_path(record.pathname, record.partial)
          }

          ::ActionView::Template.new(source, identifier, handler, details)
        end

        # Make paths as "users/user" become "users/_user" for partials.
        def virtual_path(path, partial)
          return path unless partial
          if index = path.rindex("/")
            path.insert(index + 1, "_")
          else
            "_#{path}"
          end
        end
      end
    end
  end
end
