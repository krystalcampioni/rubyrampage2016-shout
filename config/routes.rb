Rails.application.routes.draw do
  get 'reactions/create'

  get '/auth/:provider/callback', to: 'sessions#create'
  get 'logout', to: 'sessions#logout'

  root to: 'application#home'

  resources :shouts, only: [:create] do
    resources :reactions, only: [:create]
  end

  resources :users, path: 'u' do
    resources :shouts, only: [:index]
  end

  get '/users/me/shouts' => 'shouts#me', as: :current_user_shouts
end
