Rails.application.routes.draw do
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  devise_for :users
  devise_scope :user do
    get "/login" => "devise/sessions#new"
  end

  get 'home/index', to: 'home#index', as: :home
  resources :matches, only: :show do
    collection do
      get :group_stage
      get :round_of_16
      get :quarter_final
      get :semi_final
      get :final
    end
  end
  resources :statistics, only: :index

  root to: 'home#index'
end
