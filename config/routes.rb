Rails.application.routes.draw do

  get "/",                to:"home#index",        as: :login

  post "/pinned/new",               to:"album#new"
  get "/albums",                    to: "album#playground"

  get "/auth/:provider",            to: "home#create",      as: :connect
  get "/auth/:provider/callback",   to: "home#create"

  get "/logout",                    to: "home#destroy", as: :logout

  get "/users/self/media/liked",    to: "home#login", as: :root
  delete "/users/delete",           to: "home#delete", as: :onelast
  post "/users/delete",             to: "home#delete"


  get "/a/:feed_id",                to: 'album#show', as: :show
  delete "/a",                      to: "album#deletea", as: :deletion
  post "/a",                        to: "album#deletea"

  delete "/album",                  to: "album#destroy", as: :delete

  post "/album",                    to: "album#destroy"

  get "/search",                    to: "photo#search"
  post "/search",                   to: "photo#view"



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
