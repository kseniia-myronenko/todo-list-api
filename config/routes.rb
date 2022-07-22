Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :api do
    namespace :v1 do
      resources :sessions, only: %i[create]
      resources :registrations, only: %i[create]
      delete :logout, to: 'sessions#destroy'
      get :logged_in, to: 'sessions#logged_in'

      resources :projects do
        resources :tasks
      end

      root 'projects#index'
    end
  end
end
