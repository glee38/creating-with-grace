Rails.application.routes.draw do
  resources :post_thumbnails
  resources :art_media
  resources :reviews
  resources :brands
  resources :products
  resources :categories
  resources :registration_steps
  resources :profiles

  get "/registration_steps/personal" => "registration_steps#show", as: :registration_steps_personal
  
  
  devise_for :users, :controllers => { :registrations => "registrations", :omniauth_callbacks => "omniauth_callbacks" }

  get "/members" => "users#index", as: :members
  
  root to: 'welcome#index'

  get "/single" => "welcome#single"

  get "/posts/date_asc" => "posts#date_asc", as: :date_asc
  get "/posts/date_desc" => "posts#date_desc", as: :date_desc

  #put "/posts/:id/like" => "posts#upvote", as: :like_post

  resources :posts do
    resources :comments
     member do
        put "like", to: "posts#upvote", as: :like
      end
  end

  resources :users do
    resources :reviews
  end
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
