Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do
    resources :posts, :categories, :users
  end

  resources :users do
    member do
      get :profile
      get :collection
    end
  end

  resources :posts do
  	collection do
  		get :about
  	end
  	resources :replies, :controller => "post_replies"
  end

  resources :likes, :only => [:destroy, :create]

  resources :categories

  root to: 'posts#index'

  scope :path => '/api/v1/', :module => "api_v1", :as => 'v1', :defaults => { :format => :json } do
  
    post 'login' => 'auth#login'
    post 'logout' => 'auth#logout'

    resources :posts
  end

end
