Rails.application.routes.draw do
  
  root "pages#index"
  
  get 'auth/github/callback', to: 'sessions#create'
  
  resources :pages, only: [:index]
  
end
