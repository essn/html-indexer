Rails.application.routes.draw do
  resources :pages, only: [:show, :index]
end
