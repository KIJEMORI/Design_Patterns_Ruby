Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  
  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  

  
  # get '/doctors', to: 'doctor#index'
  # get '/doctors/new', to: 'doctor#new'
  # post '/doctors', to: 'doctor#create'
  # get  '/doctors/:id/edit', to: 'doctor#edit', as: "/doctors/edit"
  # patch '/doctors', to: 'doctor#update'
  resources :doctors, only: %i[index new edit create update destroy] 
  # get '/recipes', to: 'recipe#index'
  # get '/recipes/new', to: 'recipe#new'
  # post '/recipes', to: 'recipe#create'
  # get  '/recipes/:id/edit', to: 'recipe#edit', as: "/recipes/edit"
  # patch '/recipes', to: 'recipe#update'
  resources :recipes, only: %i[index new edit create update destroy]
  # get '/medicines', to: 'medicine#index'
  # get '/medicines/new', to: 'medicine#new'
  # post '/medicines', to: 'medicine#create'
  # get  '/medicines/:id/edit', to: 'medicine#edit', as: "/medicines/edit"
  # patch '/medicines', to: 'medicine#update'
  resources :medicines, only: %i[index new edit create update destroy]


  root 'pages#index'
end
