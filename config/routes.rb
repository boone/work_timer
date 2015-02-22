WorkTimer::Application.routes.draw do
  resources :events do
    collection do
      get 'current'
    end
    member do
      patch 'stop'
      post 'resume'
    end
  end

  resources :clients do
    resources :projects do
      resource :report, only: :show
    end
    resource :report, only: :show
  end

  root to: "events#index"
end
