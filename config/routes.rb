Rails.application.routes.draw do
  root 'admin/dashboard#index'

  # Devise
  devise_for :admins, path: 'admin', controllers: {
    sessions: 'admins/sessions'
  }

  resources :password_resets, except: [:show, :destroy]

  # Dashboard
  namespace :admin do
    get '/', to: 'dashboard#index'
    get 'manage', to: 'admins#index'
    resources :admins
    resources :categories
    resources :topics
    resources :questions
    resources :achievements
    resources :imports, only: [:new, :create]
  end

  scope '/api', defaults: { format: :json } do
    # Resources
    resources :topics, only: [:index, :show]
    resources :categories, only: [:index, :show]
    resources :game_session_questions, only: [:update]
    resources :game_sessions, except: [:new, :edit] do
      patch 'close', on: :member
    end
    resources :questions, except: [:new, :edit]
    resources :players, except: [:new, :edit] do
      collection do
        post 'authenticate'
        post 'authenticate_vk'
        get 'username_availability'
        get 'search'
      end
      member do
        get 'friends'
        get 'report'
      end
    end
    resources :friendships, only: [:index, :create] do
      collection do
        get 'requests'
        patch 'mark_requests_as_viewed'
        delete 'unfriend'
      end
    end
    resources :push_tokens, only: [:create] do
      collection do
        patch 'replace'
        delete 'delete'
      end
    end
    resources :purchases do
      get 'available', on: :collection
    end
    resources :achievements, only: [:index]

    # Online sessions
    resources :lobbies, only: [:create, :destroy] do
      collection do
        get 'challenges'
        get 'challenged'
        post 'challenge'
      end
      member do
        get 'find'
        post 'accept_challenge'
        post 'decline_challenge'
        patch 'close'
      end
    end

    # Rankings
    get 'rankings/general'
    get 'rankings/topic'
    get 'rankings/category'

    get 'pages/home'
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
