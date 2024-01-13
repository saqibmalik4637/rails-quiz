Rails.application.routes.draw do
  root to: 'home#index'
  namespace :api do
    namespace :v1 do
      resources :categories, only: [:index] do
        resources :quizzes, only: [:index]
      end

      resources :quizzes, only: [] do
        resources :questions, only: [:index]
      end
    end
  end
end
