Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    sign_up: 'register'
  }, :controllers => {registrations: 'users/registrations'}

  resources :users, :only =>[:show]
  get "/users/:id/recipes", to: "users#show_user_recipes", as:"show_user_recipes"
  get "/users/:id/orders", to: "users#show_user_transactions", as: "show_user_transactions"
  get '/users/:id',to: 'users#show'

  resources :transactions do
    get 'paypal', to: 'transactions#paypal'
  end
  post 'checkout', to: 'transactions#checkout'
  get 'success', to:'static_pages#success'

  #REFACTOR: can remove recipe_ingredients here, not using routes anymore
  resources :recipes do
  resources :recipe_ingredients
  end

  # post 'transactions/:id', to: 'transactions#edit', as: "edit_transaction_post"
  post 'transactions/new', to: 'transactions#create'
  post 'recipes/new', to: 'recipes#create'
  # post 'ingredients/new', to: 'ingredients#create'

  # match "/search", to: "recipes#search",
  # via: "get"
  # match '/browse/cuisine/:cuisine', to: 'recipes#browse', via: 'get', as: "search_cuisine"
  # match "browse/cuisine/:cuisine/:query", to: "recipes#browse", via: "get", as: "search_recipe_in_cuisine"

  # for admin to add ingredients to db and for AJAX POST to Nutri API
  resources :ingredients
  post '/searchnutri', to: 'ingredients#searchnutri'
  post '/searchingredient', to: 'ingredients#searchingredient'
  post '/searchdb', to: 'recipes#search'

  get '/howitworks', to:'static_pages#howitworks'
  get '/contactus', to:'static_pages#contactus'
  root 'static_pages#home'
end
