Quotebin::Application.routes.draw do
  root to: "home#index"
  # Tags
  get "tags/show"
  get 'tags', to: "tags#index", as: 'tags'
  get 'tag/:tag', to: 'tags#show', as: 'tag'
  get ':username/tags', to: "account#tags", as: 'user_tags'
  get ':username/tags/:tag', to: "account#tag", as: 'user_tag'
  # Quotes
  resources :quotes, path: "profile/quotes"
  # Profile
  get "profile" => "home#profile", as: :profile
  # Devise
  devise_for :users
  devise_scope :user do
    # Sessions
    get    'login'  => 'devise/sessions#new',     :as => :new_user_session
    post   'login'  => 'devise/sessions#create',  :as => :user_session
    delete 'logout' => 'devise/sessions#destroy', :as => :destroy_user_session
    # Password
    post   'reset_password'      => 'devise/passwords#create', as: :user_password
    get    'reset_password/new'  => 'devise/passwords#new',    as: :new_user_password
    get    'reset_password/edit' => 'devise/passwords#edit',   as: :edit_user_password
    put    'reset_password'      => 'devise/passwords#update', as: :user_password
    # Registration
    get    'register'       => 'devise/registrations#new',     as: :new_user_registration
    post   'register'       => 'devise/registrations#create',  as: :new_user_registration
    get    'profile/edit'   => 'devise/registrations#edit',    as: :edit_user_registration
    post   'profile'        => 'devise/registrations#create',  as: :user_registration
    put    'profile'        => 'devise/registrations#update',  as: :user_registration
    delete 'profile'        => 'devise/registrations#destroy', as: :user_registration
    get    'profile/cancel' => 'devise/registrations#cancel',  as: :cancel_user_registration
  end
  # Account (must be last!)
  get  ":username" => "account#index", as: :account
  get  ":username/quote/:id" => "account#quote", as: :account_quote
end
