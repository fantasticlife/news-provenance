Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index', :as => :home
  
  get '/sources' => 'sources#index', :as => :sources_list
  get '/sources/:source' => 'sources#show', :as => :sources_show
  get '/sources/:source/articles' => 'sources#articles_list', :as => :sources_articles_list
  get '/sources/:source/sources' => 'sources#sources_list', :as => :sources_sources_list
  
  get '/sources/:source/entities' => 'source_entities#index', :as => :source_entities_list
  get '/sources/:source/entities/:entity' => 'source_entities#show', :as => :source_entities_show
  
  get '/articles' => 'articles#index', :as => :articles_list
  get '/articles/by' => 'articles#by_url', :as => :articles_by_url
  get '/articles/:article' => 'articles#show', :as => :articles_show
  get '/articles/:article/articles' => 'articles#articles_list', :as => :articles_articles_list
  get '/articles/:article/entities' => 'articles#entities_list', :as => :articles_entities_list
  
  get '/entities' => 'entities#index', :as => :entities_list
  get '/entities/:entity' => 'entities#show', :as => :entities_show
  get '/entities/:entity/articles' => 'entities#articles_list', :as => :entities_articles_list
  get '/entities/:entity/sources' => 'entities#sources_list', :as => :entities_sources_list
  get '/entities/:entity/entities' => 'entities#entities_list', :as => :entities_entities_list

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
