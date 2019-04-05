Rails.application.routes.draw do
  devise_for :users
  resources :podcasts

  authenticated :user do
    root 'podcasts#index'
  end

  root 'welcome#index'
end
