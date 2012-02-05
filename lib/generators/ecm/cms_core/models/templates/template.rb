class Template < ActiveRecord::Base
  belongs_to :folder, :counter_cache => true
  
  validates :pathname, :presence => true
  validates :basename, :presence => true, :uniqueness => { :scope => :folder_id }
  validates :format,  :inclusion => Mime::SET.symbols.map(&:to_s), :allow_nil => true, :allow_blank => true
  validates :locale,  :inclusion => I18n.available_locales.map(&:to_s)
  validates :handler, :inclusion => ActionView::Template::Handlers.extensions.map(&:to_s)
  
  before_validation :update_pathname
  
  def update_pathname
    self.pathname = self.folder.fullname
  end
  
  def update_pathname!
    self.update_pathname
    self.save
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
    "#{basename}.#{locale}.#{format}.#{handler}"
  end  

  class Resolver < ActionView::Resolver
    require "singleton"
    include Singleton

    def find_templates(name, prefix, partial, details)
      conditions = {
        # :pathname    => normalize_path(name, prefix),
        :pathname    => "/#{normalize_array(details[:locale]).first}/#{prefix}/",
        :basename    => name,
        :locale      => normalize_array(details[:locale]).first,
        :format      => normalize_array(details[:formats]).first,
        :handler     => normalize_array(details[:handlers]),
        :partial     => partial || false
      }

      format = conditions.delete(:format)
      query  = ::Template.where(conditions)

      # 2) Check for templates with the given format or format is nil
      query = query.where(["format = ? OR format IS NULL", format])

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
      handler    = ActionView::Template.registered_template_handler(record.handler)

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

      ActionView::Template.new(source, identifier, handler, details)
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
