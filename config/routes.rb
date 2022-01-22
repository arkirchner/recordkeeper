# frozen_string_literal: true

Rails.application.routes.draw do
  resources :assets, path: 'holdings', only: %i[index create]

  resources :coins, only: [] do
    resources :transactions, only: %i[new create]
  end

  root 'assets#index'
end
