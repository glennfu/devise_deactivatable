module DeviseDeactivatable
  module Controllers
    module Helpers
      extend ActiveSupport::Concern

      protected
      def authenticate_deactivatee!
        if Devise::VERSION >= '5.0'
          authenticate_scope!
        else
          authenticate_user!
        end
      end
    end
  end
end
