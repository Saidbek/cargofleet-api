class API::BaseController < ApplicationController
  set_current_tenant_through_filter
  before_action :set_the_current_tenant

  include Pagy::Backend

  AVAILABLE_TEAMS = %w[team1 team2 team3 team4 team5].freeze

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  rescue_from StandardError, with: :record_invalid

  private

  def paginate_query(resource, params)
    @pagy, records = pagy(resource, page: params[:page], items: params[:limit])

    records
  end

  def render_paginated_response(resource)
    render json: paginated_response(resource)
  end

  def paginated_response(resource)
    response = {
      total: @pagy.count,
      length: @pagy.in,
      page: @pagy.page,
      limit: @pagy.items,
      links: {
        self: request.original_url
      },
      data: resource
    }

    response[:links][:prev] = add_params(request.original_url, {page: @pagy.prev}) if @pagy.prev
    response[:links][:next] = add_params(request.original_url, {page: @pagy.next}) if @pagy.next

    response
  end

  def add_params(url, params = {})
    uri = URI.parse(url)
    params = URI.decode_www_form(uri.query || "").to_h.symbolize_keys.merge(params)
    uri.query = URI.encode_www_form(params)
    uri.to_s
  end

  def set_the_current_tenant
    unless AVAILABLE_TEAMS.include?(params[:team_name])
      raise StandardError.new("Unknown tenant id, available: #{AVAILABLE_TEAMS}")
    end
    set_current_tenant Account.find_by(name: params[:team_name])
  end

  def array_as_json_with_user(relation, options = {})
    records = []

    relation.each do |object|
      records << object.as_json_with_user(options)
    end

    records
  end

  def record_not_found(exception)
    render json: { error: "#{exception.model} with id `#{exception.id}` not found" }, status: :not_found
  end

  def record_invalid(exception)
    render json: { error: exception.message }, status: :unprocessable_entity
  end
end
