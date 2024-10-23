Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "users#api_message"
  post "/users/create", to: "users#create"
  get "/users/get_data", to: "users#get_data"
  get "/users/valid_token", to: "users#valid_token"
  get "/users/get_id_by_token", to: "users#get_id_by_token"
  put "/users/edit", to: "users#update"
  post "/users/login", to: "users#login"
  delete "/users/destroy", to: "users#destroy"
end
