class API::VehiclesController < API::BaseController
  before_action :set_vehicle, only: [:show, :update, :destroy, :assign, :unassign]

  # API Endpoint: /api/vehicles
  api :GET, '/vehicles', 'Retrieve a list of vehicles'
  param :brand, String, desc: 'Filter by brand (optional)'
  param :model, String, desc: 'Filter by model (optional)'
  param :page, String, desc: 'Page number for pagination (optional)'
  param :per_page, String, desc: 'Number of records per page (optional)'

  # Description: This endpoint retrieves a paginated list of vehicles, optionally filtered by brand and model.
  def index
    @vehicles = Vehicle.includes(:driver)
    @vehicles = sort_and_filter(@vehicles, filter_columns: [:brand, :model])
    @vehicles = paginate_query(@vehicles, params)

    # Response:
    #   - Content-Type: application/json
    #   - Body: JSON array containing a list of vehicles
    render_paginated_response @vehicles
  end

  # API Endpoint: /api/vehicles/:id
  api :GET, '/vehicles/:id', 'Retrieve a specific vehicle by ID'
  param :id, :number, required: true, desc: 'ID of the vehicle to retrieve'

  # Description: This endpoint retrieves a specific vehicle by ID.
  def show
    render json: @vehicle
  end

  # API Endpoint: /api/vehicles
  api :POST, '/vehicles', 'Create a new vehicle'
  param :brand, String, desc: 'Brand of the vehicle', required: true
  param :model, String, desc: 'Model of the vehicle', required: true
  param :manufacture_year, String, desc: 'Manufacture year of the vehicle'
  param :color, String, desc: 'Color of the vehicle'
  param :image_url, String, desc: 'URL of the vehicle image'
  param :plate_number, String, desc: 'License plate number of the vehicle'
  param :engine_number, String, desc: 'Engine number of the vehicle'
  param :fuel_type, String, desc: 'Fuel type of the vehicle'
  param :active, [true, false], desc: 'Indicates whether the vehicle is active'

  # Description: This endpoint creates a new vehicle.
  def create
    @vehicle = Vehicle.new(vehicle_params)

    if @vehicle.save
      # Response:
      #   - Content-Type: application/json
      #   - Body: JSON object representing the created vehicle
      render json: @vehicle, status: :created
    else
      # Response:
      #   - Content-Type: application/json
      #   - Body: JSON object containing validation errors
      render json: @vehicle.errors, status: :unprocessable_entity
    end
  end

  # API Endpoint: /api/vehicles/:id
  api :PATCH, '/vehicles/:id', 'Update an existing vehicle by ID'
  param :id, :number, required: true, desc: 'ID of the vehicle to update'
  param :brand, String, desc: 'Brand of the vehicle'
  param :model, String, desc: 'Model of the vehicle'
  param :manufacture_year, String, desc: 'Manufacture year of the vehicle'
  param :color, String, desc: 'Color of the vehicle'
  param :image_url, String, desc: 'URL of the vehicle image'
  param :plate_number, String, desc: 'License plate number of the vehicle'
  param :engine_number, String, desc: 'Engine number of the vehicle'
  param :fuel_type, String, desc: 'Fuel type of the vehicle'
  param :active, [true, false], desc: 'Indicates whether the vehicle is active'

  # Description: This endpoint updates an existing vehicle by ID.
  def update
    if @vehicle.update(vehicle_params)
      render json: @vehicle
    else
      render json: @vehicle.errors, status: :unprocessable_entity
    end
  end

  # API Endpoint: /api/vehicles/:id
  api :DELETE, '/vehicles/:id', 'Delete a vehicle by ID'
  param :id, :number, required: true, desc: 'ID of the vehicle to delete'

  # Description: This endpoint deletes a vehicle by ID.
  def destroy
    @vehicle.destroy
  end

  # API Endpoint: /api/vehicles/:id/assign
  api :POST, '/vehicles/:id/assign', 'Assign a vehicle to a driver'
  param :id, :number, required: true, desc: 'ID of the vehicle to assign'
  param :driver_id, :number, desc: 'ID of the driver to assign the vehicle to', required: true
  param :start_date, String, desc: 'Date of assignment start', required: true
  param :start_odometer, String, desc: 'Odometer reading at the start of assignment'
  param :start_comment, String, desc: 'Comment for the assignment start'

  # Description: This endpoint assigns a vehicle to a driver.
  def assign
    @assignment = @vehicle.assignments.build(assignment_params.merge(active: true))
    if @assignment.save
      # Response:
      #   - Content-Type: application/json
      #   - Body: JSON object representing the created assignment
      render json: @assignment, status: :created
    else
      # Response:
      #   - Content-Type: application/json
      #   - Body: JSON object containing validation errors
      render json: @assignment.errors, status: :unprocessable_entity
    end
  end

  # API Endpoint: /api/vehicles/:id/unassign
  api :POST, '/vehicles/:id/unassign', 'Unassign a vehicle from a driver'
  param :id, :number, required: true, desc: 'ID of the vehicle to unassign'
  param :assignment_id, :number, desc: 'ID of the assignment to unassign', required: true
  param :end_odometer, String, desc: 'Odometer reading at the end of assignment'
  param :end_date, String, desc: 'Date of assignment end'
  param :end_comment, String, desc: 'Comment for the assignment end'

  # Description: This endpoint unassigns a vehicle from a driver.
  def unassign
    @assignment = @vehicle.assignments.find(params[:assignment_id])
    if @assignment.update(unassignment_params.merge(active: false))
      render json: @assignment
    else
      render json: @assignment.errors, status: :unprocessable_entity
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_vehicle
    @vehicle = Vehicle.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through for create action.
  def vehicle_params
    params.permit(
      :brand, :model, :manufacture_year, :color, :image_url,
      :plate_number, :engine_number, :fuel_type, :active
    )
  end

  # Only allow a trusted parameter "white list" through for assign action.
  def assignment_params
    params.permit(:driver_id, :start_date, :start_odometer, :start_comment)
  end

  # Only allow a trusted parameter "white list" through for unassign action.
  def unassignment_params
    params.permit(:end_odometer, :end_date, :end_comment)
  end
end
