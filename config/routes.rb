Rails.application.routes.draw do
  resources :links

  root 'links#index'
  resources :views, path: :v, only: :show
end
