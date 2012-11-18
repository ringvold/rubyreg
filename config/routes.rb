Rubyreg::Application.routes.draw do

  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  get "dashboard" => "dashboard#index", :as => "dashboard"

  match "/events/:id/updateOrder" => "events#updateOrder"

  resources :sessions
  resources :users
  resources :field_types

  resources :replies do
    resources :field_replies
  end

  resources :events do
    resources :fields
    member do
      get "reply"
      get "replies"
    end
  end

  root :to => 'public#index' 
end

