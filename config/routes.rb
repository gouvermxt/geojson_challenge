Rails.application.routes.draw do
  resources :geo_areas, only: %w[index]
  resources :point_checks, only: %w[create]
end
