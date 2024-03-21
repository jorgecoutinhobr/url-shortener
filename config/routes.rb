Rails.application.routes.draw do
  devise_for :users
  resources :links

  root 'links#index'
  resources :views, path: :v, only: :show
end
