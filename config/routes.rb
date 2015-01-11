Waffle::Application.routes.draw do
  root to: 'static_pages#home'

  match '/sign_up',   to: 'users#new',             via: 'get'
  match '/sign_in',   to: 'sessions#new',          via: 'get'
  match '/log_in',    to: 'sessions#new',          via: 'get'  
  match '/sign_out',  to: 'sessions#destroy',      via: 'delete'
  match '/log_out',   to: 'sessions#destroy',      via: 'delete'

  match '/help',      to: 'static_pages#help',     via: 'get'
  match '/about',     to: 'static_pages#about',    via: 'get'
  match '/contact',   to: 'static_pages#contact',  via: 'get'
  match '/userHome',  to: 'static_pages#show',     via: 'get'
  get "static_pages/home"

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :password_resets
  resources :validations
  resources :questionnaires
  resources :block_questionnaires
  resources :blocks
  resources :answer_types
  resources :studies
  resources :questions
  resources :schedule_templates
  resources :answer_sets, only: [ :create, :destroy, :index, :new, :show ]
  
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
