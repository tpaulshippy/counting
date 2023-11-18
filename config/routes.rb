Rails.application.routes.draw do
  resources :counters
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/") to the "home#index" controller action
  root "home#index"
end
