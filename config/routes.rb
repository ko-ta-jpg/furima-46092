Rails.application.routes.draw do
  devise_for :users
<<<<<<< Updated upstream
  root 'items#index'
=======
  root "items#index"
>>>>>>> Stashed changes
  resources :items, only: [:index, :new, :create]
end