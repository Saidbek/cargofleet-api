class API::VehiclesController < API::BaseController
  before_action :set_vehicle, only: [:show, :update, :destroy]

  api :GET, '/vehicles', 'Retrieve a list of vehicles'
  param :model, String, desc: 'Filter by model (optional)'
  param :page, String, desc: 'Page number for pagination (optional)'
  param :per_page, String, desc: 'Number of records per page (optional)'

  def index
    @vehicles = Vehicle.all
    @vehicles = sort_and_filter(@vehicles, filter_columns: [:model])
    @vehicles = paginate_query(@vehicles, params)

    render_paginated_response @vehicles
  end

  api :GET, '/vehicles/:id', 'Retrieve a specific vehicle by ID'
  param :id, :number, required: true, desc: 'ID of the vehicle to retrieve'

  def show
    render json: @vehicle
  end

  api :POST, '/vehicles', 'Create a new vehicle'
  param :model, String, desc: 'Model of the vehicle', required: true
  param :manufacture_year, String, desc: 'Manufacture year of the vehicle'
  param :image_url, String, allow_nil: true, desc: 'URL of the vehicle image'
  param :plate_number, String, desc: 'License plate number of the vehicle'
  param :engine_number, String, desc: 'Engine number of the vehicle'
  param :fuel_type, Vehicle.fuel_types.keys, desc: 'Fuel type of the vehicle'

  def create
    @vehicle = Vehicle.new(vehicle_params)

    if @vehicle.save
      render json: @vehicle, status: :created
    else
      render json: @vehicle.errors, status: :unprocessable_entity
    end
  end

  api :PATCH, '/vehicles/:id', 'Update an existing vehicle by ID'
  param :id, :number, required: true, desc: 'ID of the vehicle to update'
  param :model, String, desc: 'Model of the vehicle'
  param :manufacture_year, String, desc: 'Manufacture year of the vehicle'
  param :image_url, String, allow_nil: true, desc: 'URL of the vehicle image'
  param :plate_number, String, desc: 'License plate number of the vehicle'
  param :engine_number, String, desc: 'Engine number of the vehicle'
  param :fuel_type, String, desc: 'Fuel type of the vehicle'

  def update
    if @vehicle.update(vehicle_params)
      render json: @vehicle
    else
      render json: @vehicle.errors, status: :unprocessable_entity
    end
  end

  api :DELETE, '/vehicles/:id', 'Delete a vehicle by ID'
  param :id, :number, required: true, desc: 'ID of the vehicle to delete'

  def destroy
    if @vehicle.trips.exists?
      render json: { error: 'Cannot delete vehicle because there are associated trips.' }, status: :unprocessable_entity
      return
    end

    @vehicle.destroy
    head :no_content
  end

  private
  def set_vehicle
    @vehicle = Vehicle.find(params[:id])
  end

  def vehicle_params
    params.permit(:model, :manufacture_year, :image_url, :plate_number, :engine_number, :fuel_type)
  end
end
