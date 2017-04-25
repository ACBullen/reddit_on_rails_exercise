Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
  resources :subs, except: :delete
  resources :posts, except: :index do
    member do
      post :upvote
      post :downvote
    end
    resources :comments, only: :new do
      member do
        post :upvote
        post :downvote
      end
    end
  end

  resources :comments, only: [:create, :show]

end
