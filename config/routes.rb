require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :podcasts do
    scope module: 'podcasts' do
      resources :episodes, only: :create
    end
  end

  resources :episodes, only: %i[show destroy]

  namespace :rss, defaults: { format: 'rss' } do
    resources :podcasts, only: :show
  end

  authenticated :user do
    root 'home#index'
  end

  root 'welcome#index'
end
