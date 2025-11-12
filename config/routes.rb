# frozen_string_literal: true

Rails.application.routes.draw do
  root 'items#index'
  devise_for :users
  resources :items, only: %i[index new create show]
end
