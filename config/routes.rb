Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get 'api/v1/forecast', to: 'api/v1/weather#index'
  get 'api/v1/backgrounds', to: 'api/v1/images#index'
  get 'api/v1/book-search', to: 'api/v1/books#index'
  post 'api/v1/users', to: 'api/v1/users#create'
  post 'api/v1/sessions', to: 'api/v1/sessions#create'
  post 'api/v1/road_trip', to: 'api/v1/trips#index'
end
