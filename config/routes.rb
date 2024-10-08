Rails.application.routes.draw do
  namespace :site do
    get 'home/index'
  end
  namespace :users_backoffice do
    get 'home/index'
    get 'search', to: 'search#questions' 
    post 'answer', to: 'answer#question'
    get 'subject/:subject_id', to: 'search#subject', as: 'search_subject'
    get 'profile', to: 'profile#edit'
    patch 'profile', to: 'profile#update'
    get 'statistic', to: 'statistic#index'
    delete 'answer/reset_statistics', to: 'answer#reset_statistics', as: 'reset_user_statistics'
    get 'answer', to: 'answer#question'
  end
  namespace :admins_backoffice do
    get 'home/index' # Dashboard
    resources :admins # Administrators
    resources :subjects
    resources :questions
  end
  devise_for :admins, :skip => [:registrations]
  devise_for :users, controllers: { registrations: 'registrations' }
  get 'site/home/index'
  root 'site/home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
