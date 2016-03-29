Rails.application.routes.draw do

  # get 'tasks/index'
  #
  # get 'tasks/show'
  #
  # get 'tasks/new'
  #
  # get 'tasks/create'
  #
  # get 'tasks/destroy'

  get 'tasks/new', to: 'tasks#new', as: 'new_task'
  get 'tasks', to: 'tasks#index', as: 'tasks'
  post 'tasks', to: 'tasks#create'

  get 'features/index'
  get 'projects/:project_id/features', to: 'features#index', as: 'project_features'
  get 'projects/:project_id/features/new', to: 'features#new', as: 'new_project_feature'
  post 'projects/:project_id/features', to: 'features#create'
  get 'projects/:project_id/feature/:id', to: 'features#show', as: 'project_feature'
  delete 'projects/:project_id/feature/:id', to: 'features#destroy'

  get 'projects/:project_id/actors', to: 'actors#index', as: 'project_actors'
  get 'projects/:project_id/actors/new', to: 'actors#new', as: 'new_project_actor'
  post 'projects/:project_id/actors', to: 'actors#create'
  get 'projects/:project_id/actor/:id', to: 'actors#show', as: 'project_actor'
  delete 'projects/:project_id/actor/:id', to: 'actors#destroy'

  get 'features/:feature_id/stories', to: 'stories#index', as: 'feature_stories'
  get 'story/:id', to: 'stories#show', as: 'story'
  delete 'story/:id', to: 'stories#destroy'
  get 'features/:feature_id/stories/new', to: 'stories#new', as: 'new_feature_story'
  post 'features/:feature_id/stories', to: 'stories#create'

  get 'static_pages/home'
  get 'static_pages/help'
  get 'profile/edit', to: 'users#edit_profile', as: 'edit_profile'
  get 'current_project/:project_id', to: 'users#set_current_project', as: 'set_current_project'
  patch 'profile', to: 'users#update_profile', as: 'update_profile'
  patch 'password', to: 'users#update_password', as: 'update_password'

  match 'signup', to: 'users#new', via: :get
  match 'signin', to: 'authentications#new', via: [:get, :post]
  match 'signout', to: 'authentications#destroy', via: [:get]
  match 'profile', to: 'users#show', via: :get

  resources :authentications, only: [:new, :create, :destroy]
  resources :users

  resources :companies do
    resources :roles
    resources :projects, shallow: true
  end

  root 'static_pages#home'
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
