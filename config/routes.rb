Rails.application.routes.draw do
  root to: 'application#home'

  resources :users do
    resources :shouts, only: [:index]
  end

  get '/users/me/shouts' => 'shouts#me', as: :current_user_shouts
end
