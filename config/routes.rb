Rails.application.routes.draw do
  resources :pages, only: [:create, :index]
end
