Rails.application.routes.draw do
  get 'requirements/index'
  get 'projects/:project_id/requirements', to: 'requirements#index', as: 'project_requirements'
  get 'projects/:project_id/requirements/new', to: 'requirements#new', as: 'new_project_requirement'


  get 'requirements/new'

  get 'requirements/show'

  get 'requirements/create'

  get 'requirements/update'

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
