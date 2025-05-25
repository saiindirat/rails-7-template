Rails.application.routes.draw do
  # Devise routes for user sign up / sign in / etc
  devise_for :users

  # Root path should show the list of rides
  root to: "rides#index"

  # RESTful routes for rides
  resources :rides
end
