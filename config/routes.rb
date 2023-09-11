# frozen_string_literal: true

Rails.application.routes.draw do
  scope :api do
    resources :learning_paths
    resources :talents
    resources :courses
    resources :users
  end
end
