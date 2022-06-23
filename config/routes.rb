Rails.application.routes.draw do
  get "about-us", to: "about#index", as: :about
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

root to: "main#index"
end
