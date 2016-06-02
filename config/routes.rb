Rails.application.routes.draw do
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  devise_for :users, path: '/profile'
  devise_scope :user do
    get '/profile', :to => "devise/registrations#edit"
    get '/login' => "devise/sessions#new"
    delete '/logout' => "devise/sessions#destroy"
  end

  get 'home/index', to: 'home#index', as: :home
  get 'predict_champion', to: 'home#predict_champion', as: :predict_champion
  resources :matches, only: [:index, :show]
  resources :statistics, only: :index
  resources :users do
    member do
      get :statistics
    end
  end

  root to: 'matches#index'
end
