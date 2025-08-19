Rails.application.routes.draw do
  get "trainer/show"
  get "trainer_pokemon/show"
  get "game_pokemon/show"
  get "game_pokemon/index"
  get "moves/show"
  get "attempt_pokemon/create"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)8
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "home#index"

  resources :games, param: :title, only: [:index, :show] do
    resources :areas, only: [:index]
  end
  resources :nuzlockes do
    resources :attempts, only: [:new, :create]
  end

  resources :attempts, only: [:show] do
    resource :party, only: [:show]
  end

  resources :attempt_pokemon, only: [:create, :index, :edit, :update, :show, :destroy] do
    collection do
      patch :add_to_party
      patch :swap_pokemon
    end
    member do
      patch :remove_from_party 
    end
  end
  resources :areas, only: [:show]
  resources :users, only: [:index, :show], param: :name
  resources :moves, only: [:show]
  resources :game_pokemon, only: [:show]
  resources :trainer_pokemon, only: [:show]
  resources :trainers, only: [:show]
  resources :participation_events, only: [:create]
  resources :kill_events, only: [:create]
  resources :defeated_trainers, only: [:create]

  get 'trainer/:id/show_basic', to: 'trainers#show_basic', as: 'trainer_basic'
  get 'trainers/:id/battle', to: 'trainers#battle', as: 'trainer_battle'
  get 'games/:game_id/pokedex', to: 'game_pokemon#index', as: 'pokedex'

  # patch '/attempt_pokemon/add_to_party', to: 'attempt_pokemon#add_to_party'
  # patch '/attempt_pokemon/swap_pokemon', to: 'attempt_pokemon#swap_pokemon'

get '/auth/twitch/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

end