Rails.application.routes.draw do

  resources :suggestions

  get '/suggstr', to:'wrapper#landing', as: 'landing'
  get '/goodbye', to:'wrapper#goodbye', as: 'goodbye'
  get '/learnmore', to:'wrapper#credit', as: 'credit'

  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/dashboard', to: 'users#dashboard', as: 'dashboard'
  get '/dashboard/:sub', to: 'users#sub_list', as: 'sub_list'

  root 'sessions#new'
  resources :types
  resources :medium_tags
  resources :tags
  resources :queued_media
  resources :users
  resources :media

  post 'user/:user_id/:medium_id/up', to: 'users#move_up', as: 'move_medium_up'
  post 'user/:user_id/:medium_id/down', to: 'users#move_down', as: 'move_medium_down'
  post 'user/:user_id/:medium_id/completed', to: 'users#completed', as: 'medium_completed'
  post 'user/:user_id/:medium_id/rated', to: 'users#rated', as: 'medium_rated'
  get 'user/:user_id/history', to: 'users#history', as: 'user_history'
  # get 'user/:user_id', to: 'users#show', as: 'user_show'
  get 'users/:id/suggestions', to: 'users#suggestions', as: 'user_suggestions'
  get 'media/:id/suggest', to: 'suggestions#new', as: 'medium_suggestion'
  post 'media/:id/suggest', to: 'suggestions#create'
  post 'queued_media', to: 'queued_media#create'



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
