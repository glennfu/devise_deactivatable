module DeviseDeactivatable
  class Engine < ::Rails::Engine
    ActiveSupport.on_load(:action_controller) do
      include DeviseDeactivatable::Controllers::Helpers
    end

    config.after_initialize do


      if Devise::VERSION >= '5.0'
        mapping_module = Devise::Mappings
      else
        mapping_module = Devise::Mapping
      end

      mapping_module.send :include, DeviseDeactivatable::Mapping

    end
  end
end