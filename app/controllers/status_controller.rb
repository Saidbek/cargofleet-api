class StatusController < ApplicationController
  def index
    render status: :ok
  end
end
