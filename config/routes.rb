Rails.application.routes.draw do
   get "/up", to: proc { [200, { "Content-Type" => "text/plain" }, ["OK"]] }
  root "items#index"
  resources :items
end
