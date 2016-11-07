Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'users#index'

  post 'login', to: 'users#login'
  get 'logout', to: 'users#logout'

  resources :users

  get 'real-estate', to: 'real_estate#index'
  post 'real-estate/add', to: 'real_estate#add'
  get 'real-estate/:id/buy', to: 'real_estate#buy'
  get 'real-estate/:id/delete', to: 'real_estate#delete'
  get 'real-estate/:id/rent', to: 'real_estate#rent'
  get 'real-estate/:id/release', to: 'real_estate#release'

  get 'docs', to: 'ui#index'

  resources :properties, defaults: { format: :json }
  resources :activities, defaults: { format: :json }
end
