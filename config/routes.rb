Rails.application.routes.draw do
  root :to => 'users#new'
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  get "/users/favorites/:id" => "users#favorites"
  get "/top" => "users#top"
  resources :posts do
    collection do
      post :confirm
    end
  end
  resources :favorites, only: [:create, :destroy]
  resources :tops
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

end
