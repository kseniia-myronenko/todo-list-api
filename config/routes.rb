Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :api do
    namespace :v1 do
      post :signup, to: 'registrations#create'
      post :login, to: 'sessions#create'
      delete :logout, to: 'sessions#destroy'

      resources :projects do
        resources :tasks, except: %i[index] do
          resources :comments, except: %i[index] do
            resources :images, only: %i[create update]
          end
        end
      end

      root 'projects#index'
    end
  end
end
