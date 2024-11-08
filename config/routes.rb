Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show] do
    resources :goals, only: [:index, :new]
    resources :user_comments, only: [:create]

  end

  resources :goals, only: [:create, :destroy, :edit, :update, :show] do
    resources :goal_comments, only: [:create]
  end
  resources :homes, only: [:index]
  resource :session, only: [:new, :create, :destroy]
  root to: "homes#index"




















  get "/", to: "homes#index"
end
