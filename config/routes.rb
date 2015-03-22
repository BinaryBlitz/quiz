Rails.application.routes.draw do
  get 'pages/home'

  get 'achievements/index'

  root 'admin/dashboard#index'

  # Devise
  devise_for :admins, path: 'admin', controllers: {
    sessions: 'admins/sessions'
  }

  # Dashboard
  namespace :admin do
    get '/', to: 'dashboard#index'
    get 'manage', to: 'admins#index'
    resources :admins
    resources :categories
    resources :topics
    resources :questions
  end

  # Resources
  resources :topics, only: [:index, :show], defaults: { format: :json }
  resources :categories, only: [:index, :show], defaults: { format: :json }
  resources :game_session_questions, only: [:update], defaults: { format: :json }
  resources :game_sessions, except: [:new, :edit], defaults: { format: :json } do
    patch 'close', on: :member
  end
  resources :questions, except: [:new, :edit], defaults: { format: :json }
  resources :players, except: [:new, :edit], defaults: { format: :json } do
    post 'authenticate', on: :collection
    post 'authenticate_vk', on: :collection
    get 'friends', on: :member
    get 'search', on: :collection
  end
  resources :friendships, only: [:index, :create], defaults: { format: :json } do
    get 'requests', on: :collection
    patch 'mark_requests_as_viewed', on: :collection
    delete 'unfriend', on: :collection
  end
  resources :push_tokens, only: [:create], defaults: { format: :json } do
    patch 'replace', on: :collection
    delete 'delete', on: :collection
  end
  resources :purchases, defaults: { format: :json } do
    get 'available', on: :collection
  end
  resources :achievements, only: [:index], defaults: { format: :json }

  # Online sessions
  resources :lobbies, only: [:create], defaults: { format: :json } do
    get 'find', on: :member
    get 'challenges', on: :collection
    get 'challenged', on: :collection
    post 'challenge', on: :collection
    post 'accept_challenge', on: :member
    post 'decline_challenge', on: :member
    patch 'close', on: :member
  end

  # Rankings
  get 'rankings/general'
  get 'rankings/weekly'
  get 'rankings/general_by_category'
  get 'rankings/weekly_by_category'

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
