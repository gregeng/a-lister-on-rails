Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'game_sessions#new'
  resource :game_session, only: [:new, :create, :destroy]
  resources :games, only: [:show] do
    resources :rounds, :controller => 'games/rounds', only: [:show]
  end


  get '/welcome' => 'welcome#index'




end
