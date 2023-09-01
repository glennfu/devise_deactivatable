# In your gem or module
module ActionDispatch::Routing
  class Mapper

  protected

    def devise_deactivate(mapping, controllers)
      # For deactivating the current user
      post "deactivate", to: "#{controllers[:deactivate]}#create", as: "deactivate_current"

      # For deactivating a user by ID
      post "deactivate/:id", to: "#{controllers[:deactivate]}#create", as: "deactivate"

      # For reactivating a user by ID
      post "reactivate/:id", to: "#{controllers[:deactivate]}#destroy", as: "reactivate"
    end
  end
end
