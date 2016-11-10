Rails.application.routes.draw do
  get 'statics/new'

  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    sign_up: 'register'
  }, :controllers => {registrations: 'users/registrations'}

  resources :transactions

  resources :ingredients
  resources :recipes do
    resources :recipe_ingredients
  end

  get 'statics/welcome'
  get 'statics/contact'

  root 'recipes#index'

end
