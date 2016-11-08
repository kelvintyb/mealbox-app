Rails.application.routes.draw do
  resources :users do
    resources :transactions
  end
  resources :ingredients
  resources :recipes do
    resources :recipe_ingredients
  end
  root 'users#index'


end
