Rails.application.routes.draw do
  resources :users, only: [:new, :create]
  resources :homes, only: [:index]

  root to: "homes#index"




















  get "/", to: "homes#index"
end
