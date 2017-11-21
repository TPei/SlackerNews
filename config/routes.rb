Rails.application.routes.draw do

  root 'posts#index'

  constraints ValidSortOrder do

    devise_for :users
    resources :users do
      member do
        get 'posts(/:sortby)' => 'posts#user_posts', :as => :user_posts
        get 'favourites(/:sortby)' => 'posts#user_favourites', :as => :user_favourites
        get :admin_edit
        patch :admin_update
      end
    end

    resources :categories, :path => 'slackegory' do
      member do
        get 'subscribe' => 'categories#subscribe'
        get 'unsubscribe' => 'categories#unsubscribe'
        get '(:sortby)' => 'posts#category'
      end
    end

    get 'subscriptions/(:sortby)' => 'posts#subscriptions', :as => :subscriptions_posts
    resources :posts, :path => '/' do
      member do
        get 'upvote' => 'posts#upvote'
        get 'downvote' => 'posts#downvote'

        get 'favour' => 'posts#favour'
        get 'unfavour' => 'posts#unfavour'
      end
      collection do
        get '(:sortby)' => 'posts#index'
      end
      resources :comments
    end





  end # ValidSortOrderConstraint

end
