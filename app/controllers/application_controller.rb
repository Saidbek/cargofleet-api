class ApplicationController < ActionController::API
  rescue_from Apipie::ParamError do |e|
    render json: { error: e.message }, status: :unprocessable_entity
  end
end
