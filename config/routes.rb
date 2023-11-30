Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/") to the "home#index" controller action
  resources :counters

  get "up" => "rails/health#show"

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  devise_scope :user do
    unauthenticated do
      root 'home#auto_login', as: :unauthenticated_root
    end
    authenticated do
      root "counters#index"
    end
  end
end
