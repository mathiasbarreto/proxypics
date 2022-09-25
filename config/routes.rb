Rails.application.routes.draw do
  root "orders#index"

  resources :orders, only: [:index, :show, :new, :create, :edit, :update]
end
