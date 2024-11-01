Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "users#api_message"
  post "/users/create", to: "users#create"
  get "/users/get_data", to: "users#get_data"
  get "/users/get_data_by_id", to: "users#get_data_by_id"
  put "/users/edit", to: "users#update"
  delete "/users/destroy", to: "users#destroy"
  post "/users/login", to: "users#login"
  get "/users/get_user_id", to: "users#get_id"
end
