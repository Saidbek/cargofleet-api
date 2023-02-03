class API::BaseController < ApplicationController
  include Pagy::Backend

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
end
