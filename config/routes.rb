Rails.application.routes.draw do
  root 'home#index'

  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'

  namespace :webhooks do
    post 'hb' => 'hb#perform'
  end
end
