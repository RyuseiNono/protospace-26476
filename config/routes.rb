Rails.application.routes.draw do
  get 'users/show'
  get 'comment/create'
  devise_for :users
  root to: "prototypes#index"
  resources :prototypes  do
    resources :comments, only: :create
  end
  resources :users, only: :show
end
