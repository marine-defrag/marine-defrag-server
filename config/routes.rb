# frozen_string_literal: true

Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up", to: proc { [200, {}, ["success"]] }, as: :rails_health_check

  mount_devise_token_auth_for "User", at: "auth"
  # , controllers: {
  #   sessions: "overrides/sessions"
  # }

  resources :taxonomies do
    resources :categories
  end
  get "static_pages/home"
  get "s3/sign"

  resources :actor_categories, only: [:index, :show, :create, :destroy]
  resources :actor_measures, only: [:index, :show, :create, :update, :destroy]
  resources :actors
  resources :actortype_taxonomies, only: [:index, :show]
  resources :actortypes, only: [:index, :show]
  resources :feedbacks, only: [:create]
  resources :measure_actors, only: [:index, :show, :create, :update, :destroy]
  resources :measure_categories
  resources :measure_indicators
  resources :measure_resources
  resources :measuretype_taxonomies, only: [:index, :show]
  resources :measuretypes, only: [:index, :show]
  resources :memberships, only: [:index, :show, :create, :destroy]
  resources :recommendation_categories
  resources :resourcetypes, only: [:index, :show]
  resources :user_categories
  resources :recommendation_measures
  resources :categories do
    resources :recommendations, only: [:index, :show]
    resources :measures, only: [:index, :show]
  end
  resources :recommendations do
    resources :measures, only: [:index, :show]
  end
  resources :measures do
    resources :recommendations, only: [:index, :show]
  end
  resources :indicators do
    resources :measures, only: [:index, :show]
    resources :progress_reports, only: [:index, :show]
  end
  resources :progress_reports
  resources :users
  resources :user_roles
  resources :roles
  resources :pages
  resources :resources
  resources :bookmarks

  resources :frameworks, only: [:index, :show]
  resources :framework_frameworks, only: [:index, :show]
  resources :framework_taxonomies, only: [:index, :show]

  resources :recommendation_recommendations, except: [:update]
  resources :recommendation_indicators, except: [:update]

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  root to: "static_pages#home"
end
