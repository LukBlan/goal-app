Rails.application.routes.draw do
  resources :users, only: [:new, :create] do
    resources :goals, only: [:index, :new]
  end

  resources :goals, only: [:create, :destroy, :edit, :update]
  resources :homes, only: [:index]
  resource :session, only: [:new, :create, :destroy]
  root to: "homes#index"




















  get "/", to: "homes#index"
end
