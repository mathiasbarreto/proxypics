Rails.application.routes.draw do
  devise_for :assignees
  devise_for :requesters
  
  get "home/index"  
  root to: "home#index"  

  namespace :api do
    namespace :v1 do
       resources :orders, only: [:index, :show, :new, :create, :edit, :update]
    end
  end

  resources :orders, only: [:index, :show, :new, :create, :edit, :update]
end
