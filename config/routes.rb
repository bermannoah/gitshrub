Rails.application.routes.draw do
  
  root "pages#index"
  
  get 'auth/github/callback', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  get 'repos', to: 'users#repos'
  post 'new_repo', to: 'users#new_repo'
  
  resources :pages, only: [:index]
  resources :users
  
end