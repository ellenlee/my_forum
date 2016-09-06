Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :topics do
  	resources :comments, :controller => "topic_comments"
  end

  root to: 'topics#index'
end
