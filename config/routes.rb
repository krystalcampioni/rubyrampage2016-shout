Rails.application.routes.draw do
  get '/auth/:provider/callback', to: 'sessions#create'

  root to: 'application#home'

  resources :shouts, only: [:create]

  resources :users, path: 'u' do
    resources :shouts, only: [:index]
  end

  get '/users/me/shouts' => 'shouts#me', as: :current_user_shouts
end
