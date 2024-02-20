class API::TripsController < API::BaseController
  api :GET, '/trips', 'Retrieve a list of trips'
  param :page, String, desc: 'Page number for pagination (optional)'
  param :per_page, String, desc: 'Number of records per page (optional)'

  def index
    @driver = Driver.find(params[:driver_id])
    @trips = @driver.trips
    @trips = paginate_query(@trips, params)

    render_paginated_response @trips
  end

  api :POST, '/api/drivers/:driver_id/trips', "Create a new driver's trip"
  param :driver_id, :number, desc: 'ID of the associated driver'
  param :vehicle_id, :number, desc: 'ID of the associated vehicle'
  param :departure_location, String, desc: 'The departure location'
  param :arrival_location, String, desc: 'The arrival location'
  param :start_date, String, desc: 'Start date of the trip'
  param :end_date, String, desc: 'End date of the trip'
  param :distance, String, desc: 'Distance of the trip'
  param :duration, String, desc: 'Duration of the trip'

  def create
    @driver = Driver.find(params[:driver_id])
    @trip = @driver.trips.build(trip_params)
    if @trip.save
      render json: @trip, status: :created
    else
      render json: @trip.errors, status: :unprocessable_entity
    end
  end

  api :PATCH, '/api/drivers/:driver_id/trips/:id/complete', "Complete a driver's trip"
  param :driver_id, :number, desc: 'ID of the associated driver'
  param :id, :number, desc: 'ID of the associated trip'
  def complete
    @driver = Driver.find(params[:driver_id])
    @trip = @driver.trips.find(params[:id])
    if @trip.update(completed: true)
      render json: @trip, status: :no_content
    else
      render json: @trip.errors, status: :unprocessable_entity
    end
  end

  private

  def trip_params
    params.permit(:driver_id, :vehicle_id, :departure_location, :arrival_location, :start_date, :end_date, :distance, :duration)
  end
end
