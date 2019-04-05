Rails.application.routes.draw do
  devise_for :users
  resources :podcasts

  namespace :rss, defaults: { format: 'rss' } do
    resources :podcasts, only: :show
  end

  authenticated :user do
    root 'podcasts#index'
  end

  root 'welcome#index'
end
