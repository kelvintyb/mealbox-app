Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    sign_up: 'register'
  }, :controllers => {registrations: 'users/registrations'}

  resources :users, :only =>[:show]


  resources :transactions

  resources :ingredients
  resources :recipes do
    resources :recipe_ingredients
  end

  match '/users/:id',to: 'users#show', via: 'get'

  root 'static_pages#home'

end
