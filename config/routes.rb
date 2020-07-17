Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  scope module: 'api' do
    namespace :v1 do
      resources :artists
      resources :blogs do
        resources :records, defaults: { format: :json }
      end
      resources :labels
      resources :records do
        collection do
          get :calendar
        end
      end
      resources :tags
      post '/search', to: 'search#index'
    end
  end 
end
