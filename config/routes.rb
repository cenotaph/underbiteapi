Rails.application.routes.draw do
  scope module: 'api' do
    namespace :v1 do
      resources :blogs do
        resources :records
      end
      resources :records
      resources :tags
      post '/search', to: 'search#index'
    end
  end 
end
