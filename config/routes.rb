Rails.application.routes.draw do
  root 'static_pages#home'

  # static
  get 'static_pages/home'
  get 'static_pages/help'

  get 'dashboard', to: 'dashboard#index', as: 'dashboard'

  resources :companies do
    resources :roles
    resources :projects, shallow: true
  end

  #tasks
  resources :tasks, only: [:show, :destroy, :new, :index, :create] do
    member do
      get 'state', action: :show_state
      patch 'state', action: :update_state
    end
  end

  resources :projects do
    patch 'current', to: 'users#current_project', on: :member
    resources :features, shallow: true
    resources :actors, shallow: true
    resources :stories, shallow: true
    resources :tasks, only: [:index], shallow: true
  end

  get 'projects/:project_id/users_search', to: 'projects#users_search', as: 'project_users_search'

  resources :features do
    resources :stories, shallow: true
  end

  resources :authentications, only: [:new, :create, :destroy]

  resource :user, path_names: { new: 'signup'}

  # users
  get 'profile/edit', to: 'users#edit_profile', as: 'edit_profile'
  patch 'profile', to: 'users#update_profile', as: 'update_profile'
  patch 'password', to: 'users#update_password', as: 'update_password'

  get 'signup', to: 'users#new'
  get 'signin', to: 'authentications#new'
  get 'signout', to: 'authentications#destroy'
  get 'profile', to: 'users#show'

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
