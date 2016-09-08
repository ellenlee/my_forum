Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users do
    member do
      get :profile
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

end
