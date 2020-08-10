require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      namespace :amazon do
        resources :prime_products, only: %i[index show destroy update]
        resources :prime_videos, only: %i[index show destroy update]
      end
    end
  end
end
