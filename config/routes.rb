Rails.application.routes.draw do
  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  get '/docs', to: 'articles#index'
  get '/guides', to: 'lectures#index'
  get '/community', to: 'community#index'

  resources :articles do
    member do
      get 'slides'
    end
  end
  resources :lectures do
    member do
      get 'slides'
      get 'print'
    end
  end
  resources :workshops
  get '/:workshop', to: 'workshops#show'
  get '/:workshop/:lecture', to: 'lectures#show'
  get '/:workshop/:lecture/slides', to: 'lectures#slides'

  root to: "lectures#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
