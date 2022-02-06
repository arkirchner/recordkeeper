# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  resources :assets, path: 'holdings', only: %i[index create]

  resources :coins, only: [] do
    resources :transactions, only: %i[new create]
  end

  root 'assets#index'

  mount Sidekiq::Web => '/sidekiq'
end
