Rails.application.routes.draw do
  
  root "pages#index"
  
  get 'auth/github/callback', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  
  resources :pages, only: [:index]
  resources :users
  
end
