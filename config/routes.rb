Rails.application.routes.draw do
  get 'pagesgro/index'

  get 'pagesgro/tele'

  get 'pagesgro/staff'

  get 'pagesgro/company'
  
  post 'pagesgro/company'

  get 'pagesgro/overall'
  
  post 'pagesgro/add'
  
  post 'pagesgro/update'
  
  get 'pagesgro/loginPage'
  
  post 'pagesgro/login'
  
  get 'pagesgro/logout'
  
  get 'pagesgro/edit'
  
  post 'pagesgro/edit2'
  
  get 'pagesgro/delete'
  
  post 'pagesgro/adduser'
  
  get 'pagesgro/editRecord'
  
  patch 'pagesgro/editRecord2'
  
  get 'pagesgro/deleteRecord'
  
  get 'pagesgro/loginRecord'
  
  
  
  
  
  get 'pages/index'

  get 'pages/tele'

  get 'pages/staff'

  get 'pages/company'
  
  post 'pages/company'

  get 'pages/overall'
  
  post 'pages/add'
  
  post 'pages/update'
  
  get 'pages/loginPage'
  
  post 'pages/login'
  
  get 'pages/logout'
  
  get 'pages/edit'
  
  post 'pages/edit2'
  
  get 'pages/delete'
  
  post 'pages/adduser'
  
  get 'pages/editRecord'
  
  patch 'pages/editRecord2'
  
  get 'pages/deleteRecord'
  
  get 'pages/loginRecord'
  
  
  
  

  
  
  
  get 'admins/index'
  
  root 'admins#index'

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
