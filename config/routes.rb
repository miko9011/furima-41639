Rails.application.routes.draw do
<<<<<<< Updated upstream
=======
<<<<<<< Updated upstream
>>>>>>> Stashed changes
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
=======
  get 'items/index'
  devise_for :users
>>>>>>> Stashed changes

  # トップページを items#index に設定
  root "items#index"

  # items の index を使うために必要
  resources :items, only: :index

  get "up" => "rails/health#show", as: :rails_health_check
end