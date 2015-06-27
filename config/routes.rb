Rails.application.routes.draw do
  resources :room_answers
  resources :room_questions
  resources :room_sessions
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
    resources :facts
    resources :imports, only: [:new, :create]
  end

  scope '/api', defaults: { format: :json } do
    # Topics & categories
    resources :topics, only: [:index, :show]
    resources :categories, only: [:index, :show]

    resources :game_session_questions, only: [:update]
    resources :game_sessions, except: [:new, :edit] do
      patch 'close', on: :member
    end
    resources :rooms, except: [:new, :edit] do
      member do
        post 'join'
        post 'start'
        delete 'leave'
      end
    end
    resources :room_sessions, only: [:show]
    resources :room_questions, only: [] do
      member do
        post 'answer'
      end
    end

    # Players & friends
    resources :players, except: [:new, :edit] do
      collection do
        post 'authenticate'
        post 'authenticate_vk'
        get 'search'
      end
      member do
        get 'friends'
        get 'report'
        post 'notify'
      end
    end
    resources :friend_requests, except: [:new, :edit]
    resources :friends, only: [:index, :destroy]
    resources :achievements, only: [:index]

    # Mobile
    resources :push_tokens, only: [:create] do
      collection do
        patch 'replace'
        delete 'delete'
      end
    end
    resources :purchases do
      get 'available', on: :collection
    end

    # Game
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

    # Pages
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
