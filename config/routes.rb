Bukkit::Application.routes.draw do
  resources :accounts 
  resources :activations
  resources :items
  match "/configure" => "accounts#new"
  match "/edition" => "items#index"
end
