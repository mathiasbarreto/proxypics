Rails.application.routes.draw do
  root "orders#index"

  namespace :api do
    namespace :v1 do
      resources :orders, only: [:index, :show, :new, :create, :edit, :update]
    end
  end

  resources :orders, only: [:index, :show, :new, :create, :edit, :update]
end
