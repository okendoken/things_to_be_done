GreatWork::Application.routes.draw do
  root :to => "home#index"

  resources :user_info

  resources :user

  resources :notifications, :only => [:index] do
    #it's better to use 'get' on collection
    post 'get_new_notifications', :on => :collection
  end

  match 'home' => 'user#show', :as => :user_home


  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" } do
    match 'users/auth/twitter/twitter_email' => 'users/omniauth_callbacks#twitter_email'
    match 'users/auth/vkontakte/vkontakte_email' => 'users/omniauth_callbacks#vkontakte_email'
  end

  resources :countries, :path => "loc", :only => [:show] do
    resources :cities, :path => "", :only => [:show]
  end

  resources :comments, :only => [:destroy] do
    member do
      post 'support'
      post 'notsupport'
    end
  end

  resources :activities, :only => [:destroy] do
    member do
      post 'support'
      post 'notsupport'
    end
  end

  #legacy crappy code
  match ':project_id(/:task_id)/support' => 'vote#support', :as => :support_route
  match ':project_id(/:task_id)/notsupport' => 'vote#not_support', :as => :not_support_route

  match ':project_id(/:task_id)/participators' => 'user#participators', :as => :participators
  match ':project_id(/:task_id)/supporters' => 'user#supporters', :as => :supporters

  match ':project_id/:id/participate' => 'tasks#participate'
  match ':project_id/:id/leave' => 'tasks#leave'
  #end legacy crappy code

  resources :projects, :only => [:new, :create]
  resources :tasks, :only => [:new, :create] do
    get :autocomplete_city_name, :on => :collection
  end

  resources :projects, :path => "", :except => [:index, :create, :new ] do
    member do
      get 'news'
      get 'tasks'
      scope 'admin' do
        post 'manage'
      end
    end
    resources :comments, :only => [:index, :create]
    resources :activities, :only => [:index, :create]
    resources :tasks, :path => "", :except => [:index, :create, :new ] do
      member do
        get 'news'
        scope 'admin' do
          post 'manage'
        end
      end
      resources :comments, :only => [:index, :create]
      resources :activities, :only => [:index, :create]
    end
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
