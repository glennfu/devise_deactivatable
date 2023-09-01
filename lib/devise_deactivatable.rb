module DeviseDeactivatable
  autoload :Mapping, 'devise_deactivatable/mapping'
  module Controllers
    autoload :Helpers, 'devise_deactivatable/controllers/helpers'
  end
end

require 'devise'
require 'devise_deactivatable/routes'
require 'devise_deactivatable/rails'

Devise.add_module(:deactivatable,
  model: 'devise_deactivatable/model',
  route: { deactivate: [:create] }
)
