Rails.application.routes.draw do
  root to: 'home#index'
  namespace :api do
    namespace :v1 do
      get '/me', to: 'users#me'

      resources :users, only: [:create]

      resources :categories, only: [:index] do
        resources :quizzes, only: [:index]
      end

      resources :quizzes, only: [:index] do
        resources :questions, only: [:index]
      end

      resources :carousels, only: [:index]

      get '/search/suggestions/:query', to: 'search#suggestions', as: :suggestions
    end
  end
end
