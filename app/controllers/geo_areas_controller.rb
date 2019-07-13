class GeoAreasController < ApplicationController
  def index
    geo_areas = GeoAreas.new.as_hash
    render json: { geo_areas: geo_areas }, status: :ok
  end
end