# mapping.rb
module DeviseDeactivatable
  module Mapping
    def self.included(base)
      base.prepend(InstanceMethods)
    end

    module InstanceMethods
      private
      def default_controllers(options)
        options[:controllers] ||= {}
        super
      end
    end
  end
end
