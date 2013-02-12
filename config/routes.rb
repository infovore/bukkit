Bukkit::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

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

  resource :telephony, :controller => "telephony"

  match "/configure" => "accounts#new"
  match "/edition" => "items#index"
  match "/sample" => "items#sample"
  root :to => "pages#index"
end
