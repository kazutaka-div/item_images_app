Rails.application.routes.draw do
  root to: 'items#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end

  resources :items do
    resources :likes, only: [:index, :destroy, :show]
    member do
      get "buy"
      post "buyafter"
    end
  end

  resources :users, only: :show

  resources :cards, only: [:index, :new, :create, :destroy]

end
