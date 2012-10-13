Quotebin::Application.routes.draw do
  root to: "home#index"
  resources :quotes
  devise_for :users
end
