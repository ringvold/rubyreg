Rubyreg::Application.routes.draw do

  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"


  get "/events/:id/reply" => "events#reply"
  get "/events/:id/confirmation" => "events#thanks", as: "confirmation_event"
  post "/replies" => "replies#create", as: "new_reply"

  scope "/admin" do
    match "/events/:id/updateOrder" => "events#updateOrder"

    get "dashboard" => "dashboard#index", :as => "dashboard"
    get "/" => "dashboard#index"

    resources :users
    resources :field_types

    resources :replies do
      collection do
        post "delete"
      end
      resources :field_replies
    end

    resources :events do
      resources :fields
      member do
        get "reply"
        get "replies"
      end
    end
  end


  resources :sessions


  root :to => 'public#index'
end

