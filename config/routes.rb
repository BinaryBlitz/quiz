Rails.application.routes.draw do
  get 'proposals/create'

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
    resources :topics do
      get 'export', on: :member
    end
    resources :questions, except: [:index, :show]
    resources :achievements
    resources :facts
    resources :purchase_types
    resources :imports, only: [:new, :create]
    resources :proposals, only: [:index, :destroy] do
      post 'approve', on: :member
    end
    resources :reports, only: [:index, :destroy] do
      collection do
        get 'players'
        get 'questions'
        get 'feedback'
      end
    end
  end

  scope '/api', defaults: { format: :json } do
    # Topics & categories
    resources :topics, only: [:index, :show]
    resources :categories, only: [:index, :show]
    resources :proposals, only: [:create]

    # TODO: Deprecate
    patch 'game_session_questions/:id' => 'game_questions#update'

    resources :game_questions, only: [:update]
    resources :game_sessions, except: [:index, :new, :edit] do
      patch 'close', on: :member
    end
    resources :rooms, except: [:new, :edit] do
      post 'messages', to: 'room_messages#create'
      member do
        post 'join'
        post 'start'
        post 'invite'
        post 'finish'
        delete 'leave'
      end
    end
    resources :invites, except: [:new, :edit]
    resources :participations, except: [:new, :edit]
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
        get 'version'
      end
      member do
        get 'friends'
        get 'report'
        post 'notify'
      end
    end
    resources :friend_requests, except: [:new, :edit]
    resources :friends, only: [:index, :destroy]
    resources :messages, only: [:index, :create]
    resources :achievements, only: [:index]

    resources :purchases do
      get 'available', on: :collection
    end
    resources :reports, only: [:create]

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

    resources :rankings, only: :index

    # Pages
    get 'pages/home'
  end
end
