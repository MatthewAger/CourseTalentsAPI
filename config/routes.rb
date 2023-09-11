# frozen_string_literal: true

Rails.application.routes.draw do
  scope :api do
    resources :learning_paths
    resources :courses
    resources :users do
      resources :courses, only: :update, controller: 'users/courses'
    end
  end
end
