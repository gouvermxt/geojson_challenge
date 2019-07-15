# Handles unhandled exceptions with a standard response
module ApiExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError, with: :bad_request
  end

  def bad_request(e)
    logger.error e

    render json: { 
      error: 'An unknow error happened. Please contact the system administrators.' 
    }, status: 500
  end
end