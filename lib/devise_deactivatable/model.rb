module Devise
  module Models
    module Deactivatable
      extend ActiveSupport::Concern

      included do
        scope :deactivated, -> { where.not(deactivated_at: nil) }
      end

      def self.required_fields(klass)
        [:deactivated_at]
      end

      # Overwrites active_for_authentication? from Devise::Models::Activatable for deactivate purposes
      # by verifying whether a user is active to sign in or not based on deactivated?
      def active_for_authentication?
        !deactivated? && super
      end

      def deactivate!
        self.deactivated_at = Time.now
        save(validate: false) or raise "Devise deactivatable could not save #{inspect}." \
          "Please make sure a model using deactivatable can be saved when deactivating."

        after_deactivate
      end

      def reactivate!
        self.deactivated_at = nil
        save(validate: false) or raise "Devise deactivatable could not save #{inspect}." \
          "Please make sure a model using deactivatable can be saved when reactivating."

        after_reactivate
      end

      def deactivated?
        !!deactivated_at
      end

      # Overwrites invalid_message from Devise::Models::Authenticatable to define
      # the correct reason for blocking the sign in.
      def inactive_message
        deactivated? ? :deactivated : super
      end

      protected

      # A callback initiated after successfully deactivating. This can be
      # used to insert your own logic that is only run after the user successfully
      # deactivated.
      #
      # Example:
      #
      #   def after_deactivated
      #     # remove oauth tokens
      #   end
      #
      def after_deactivate
      end

      # A callback initiated after successfully reactivating. This can be
      # used to insert your own logic that is only run after the user successfully
      # reactivated.
      #
      # Example:
      #
      #   def after_reactivated
      #     # send email informing of reactivation
      #   end
      #
      def after_reactivate
      end

      module ClassMethods

      end
    end
  end
end
