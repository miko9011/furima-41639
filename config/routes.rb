Rails.application.routes.draw do
  # トップページを items#index に設定
  root "items#index"
  devise_for :users
  # items の index を使うために必要
  resources :items, only: :index


end