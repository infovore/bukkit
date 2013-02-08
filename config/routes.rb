Bukkit::Application.routes.draw do
  resources :accounts 
  resources :activations
  resources :items
  resources :pages do
    collection do
      get :about
    end
  end

  match "/configure" => "accounts#new"
  match "/edition" => "items#index"
  root :to => "pages#index"
end
