Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :jobs, only: [:index, :show] do
    resources :likes, only: [:create, :update]

    resources :interviews, shallow: true do
      resources :questions, shallow: true do
        resources :answers, shallow: false
      end
      member do
        get :transcript
      end
    end
  end

  resources :likes, only: [:destroy]

  resources :candidates do
    member do
      get :favorite_jobs
    end
    resources :job_applications, only: [:index]
  end

  resources :job_applications, only: [:show]
  resources :companies do
    member do
      get :published_jobs
    end
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root 'pages#dashboard'
end
