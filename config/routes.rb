Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'users#index'

  post 'login', to: 'users#login'
  get 'logout', to: 'users#logout'

  resources :users
  resources :properties, defaults: { format: :json }

  get 'docs', to: 'ui#index'

end
