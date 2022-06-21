class ApplicationController < ActionController::API
  rescue_from StandardError, with: :show_errors

  private

  def show_errors(exception)
    error_json = {
      success: false,
      message: 'API Error',
      error: exception.message
    }
    render json: error_json, status: 500
  end
end
