Bukkit::Application.routes.draw do
  resources :accounts 
  resources :activations
  resources :items do
    collection do
      get :sample
    end
  end
  resources :pages do
    collection do
      get :about
    end
  end

  match "/configure" => "accounts#new"
  match "/edition" => "items#index"
  match "/sample" => "items#sample"
  root :to => "pages#index"
end
