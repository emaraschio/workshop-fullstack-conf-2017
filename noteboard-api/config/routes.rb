Rails.application.routes.draw do
  get 'health', to: 'application#health'
  namespace :api do
    namespace :v1 do
      resources :notes
    end
  end
end
