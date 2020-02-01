Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/', to: 'merchants#index'
        get '/find_all', to: 'find#index'
        get '/find', to: 'find#show'
        get '/random', to: 'random#show'
        get '/:id', to: 'merchants#show'
        get '/:merchant_id/items', to: 'items#index'
      end

      namespace :customers do
        get '/', to: 'customers#index'
        get '/find_all', to: 'find#index'
        get '/find', to: 'find#show'
        get '/random', to: 'random#show'
        get '/:id', to: 'customers#show'
      end
    end
  end
end
