Rails.application.routes.draw do
  root to: "dashboard#index"

  resources :payments, only: [:new, :create]
  resources :payouts, only: [:index, :new, :create] do
    resources :transactions, only: [:index]
  end
  resources :transactions, only: [:index]
end
