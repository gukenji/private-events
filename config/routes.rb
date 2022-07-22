Rails.application.routes.draw do
  
  devise_for :users, :controllers => { 
    registrations: 'registrations'
  }
  
  resources :events
  resources :users, :only => [:show]
  resources :attendees_events, :only => [:new, :create, :destroy]

  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Defines the root path route ("/")
  root to: "home#index"
end
