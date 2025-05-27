Rails.application.routes.draw do
  # Devise routes for user sign up / sign in / etc
  devise_for :users

  # Root path should now show the new HomeController#index
  root to: "home#index"

  # RESTful routes for rides
  resources :rides

  # Routes for joining/leaving rides
  resources :ride_participants, only: [:create, :destroy]

  # Explicit route for home controller
  get "/home", to: "home#index"
end
