Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :jobs do
    resources :interviews, shallow: true do
      resources :questions, shallow: true do
        resources :answers, shallow: false
      end
    end
  end

  resources :candidates
  resources :companies

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root 'pages#dashboard'
end
