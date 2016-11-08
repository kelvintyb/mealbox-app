Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    sign_up: 'register'
  }
  resources :users do
    resources :transactions
  end
  resources :ingredients
  resources :recipes do
    resources :recipe_ingredients
  end
  root 'users#index'
end
