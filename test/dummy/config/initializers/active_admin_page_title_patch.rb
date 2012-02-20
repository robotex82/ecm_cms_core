module ActiveAdmin
  module Views
    module Pages
      class Index < Base
        def title
          case config[:title]
          when Symbol, Proc
            call_method_or_proc_on(resource, config[:title])
          when String
            config[:title]
          else
            active_admin_config.plural_resource_name
          end
        end
      end
    end
  end
end
