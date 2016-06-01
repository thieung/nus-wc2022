Rails.application.routes.draw do
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  devise_for :users
  devise_scope :user do
    get "/login" => "devise/sessions#new"
  end

  get 'home/index', to: 'home#index', as: :home

  root to: 'home#index'
end
