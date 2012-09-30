Forails::Engine.routes.draw do
  
  resources :topics, :except => [:index, :new] do
    resources :comments, :except => [:index, :show], :as => :comments
  end

  resources :forums, :only => [:index, :show] do
    resources :topics, :only => [:new]
  end
  
  resources :admin, :only => [:index]
  namespace :admin do
    resources :forums, :except => [:index, :show]
    resources :groups
  
    get "users/search" => "users#search"
    get "users/:id" => "users#edit", as: 'users'
    put "users/:id" => "users#update", as: 'users'
  end

  root to: "forums#index"
end
