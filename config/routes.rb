Rails.application.routes.draw do
  resources :users, only: [:new, :create]
  resources :homes, only: [:index]
  resource :session, only: [:new, :create, :destroy]
  root to: "homes#index"




















  get "/", to: "homes#index"
end
