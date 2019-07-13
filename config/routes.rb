Rails.application.routes.draw do
  resources :geo_areas, only: %w[index]
end
