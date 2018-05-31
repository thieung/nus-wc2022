Rails.application.routes.draw do
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  devise_for :users, path: '/profile', controllers: {
    registrations: 'registrations'
  }
  devise_scope :user do
    get '/profile', :to => "devise/registrations#edit"
    get '/login' => "devise/sessions#new"
    delete '/logout' => "devise/sessions#destroy"
  end

  get 'home/index', to: 'home#index', as: :home
  get 'predict_champion', to: 'users#predict_champion', as: :predict_champion
  get 'management', to: 'home#management', as: :management
  resources :matches, only: [:index, :show] do
    member do
      post :predict_score
      post :predict_score_edit_view
      get :update_betting_scores
      get :update_match_score
      post :import_number_users
      post :import_user_betting_scores
      get :add_row
      post :update_score
      post :future_match_update_info
      post :random_score
      post :send_report_email_to_all_staffs
    end
  end
  resources :statistics, only: :index do
    collection do
      get :records
    end
  end
  resources :users do
    member do
      get :statistics
      get :change_status
      post :import_predict_champion
    end
    collection do
      post :pick_champion
    end
  end

  root to: 'matches#index'

  get '*path' => redirect('/')
end
