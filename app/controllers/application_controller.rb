class ApplicationController < ActionController::API
  before_action :authenticate

  rescue_from Apipie::ParamError do |e|
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  def authenticate
    token = request.headers['Authorization']
    unless token == ENV.fetch('AUTHORIZATION_TOKEN', 'Zb84MzAROCrhmF6t')
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
