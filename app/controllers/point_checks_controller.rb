class PointChecksController < ApplicationController
  def create
    result = PointChecker.new.within_areas?(point_check_params.to_json)

    if error = result[:error]
      render json: { error: error }, status: :bad_request
    else
      render json: { inside?: result[:is_inside] }, status: :created
    end
  end

  def point_check_params
    params.require(:point)
  end
end