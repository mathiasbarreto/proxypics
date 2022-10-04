Rails.application.routes.draw do
  devise_for :requesters
  
  root to: "home#index"

  namespace :api do
    namespace :v1 do
       resources :orders, only: [:index, :show, :new, :create, :edit, :update]
    end
  end

  resources :orders, only: [:index, :show, :new, :create, :edit, :update]
end
