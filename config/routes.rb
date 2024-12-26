Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  root to: 'home#index'

  namespace :api do
    namespace :v1 do
      get '/me', to: 'users#me'

      resources :users, only: [:create]

      resources :categories, only: [:index] do
        resources :quizzes, only: [:index]
      end

      resources :quizzes, only: [:index, :show] do
        resources :questions, only: [:index]

        member do
          post :mark_favorited
          post :unmark_favorited
          post :mark_played
        end
      end

      resources :carousels, only: [:index]

      resources :report_cards, only: [:create, :show]

      resources :rooms, only: [:create, :show] do
        member do
          post :leave
          get :scoreboard
        end
      end

      post '/rooms/:joining_code/join', to: 'rooms#join', as: :join

      get '/search/suggestions/:query', to: 'search#suggestions', as: :suggestions
    end
  end
end
