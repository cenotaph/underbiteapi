Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  scope module: 'api' do
    namespace :v1 do
      resources :artists
      resources :blogs do
        resources :records, defaults: { format: :json }
      end
      resources :labels
      resources :records, defaults: { format: 'json' } do
        collection do
          get :calendar
        end
      end
      resources :tags, defaults: { format: 'json' } do
        collection do
          get :random
        end
      end
      post '/search', to: 'search#index'
    end
  end
end
