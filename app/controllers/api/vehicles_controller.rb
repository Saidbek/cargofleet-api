class API::VehiclesController < API::BaseController
  before_action :set_vehicle, only: [:show, :update, :destroy, :assign, :unassign]

  # GET /vehicles
  def index
    @vehicles = paginate_query(Vehicle.order(:id), params)

    render_paginated_response @vehicles
  end

  # GET /vehicles/1
  def show
    render json: @vehicle
  end

  # POST /vehicles
  def create
    @vehicle = Vehicle.new(vehicle_params)

    if @vehicle.save
      render json: @vehicle, status: :created
    else
      render json: @vehicle.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /vehicles/1
  def update
    if @vehicle.update(vehicle_params)
      render json: @vehicle
    else
      render json: @vehicle.errors, status: :unprocessable_entity
    end
  end

  # DELETE /vehicles/1
  def destroy
    @vehicle.destroy
  end

  # POST /vehicles/1/assign
  def assign
    @assignment = @vehicle.assignments.build(assignment_params)

    if @assignment.save
      render json: @assignment, status: :created
    else
      render json: @assignment.errors, status: :unprocessable_entity
    end
  end

  # POST /vehicles/1/unassign
  def unassign
    @assignment = @vehicle.assignments.find(params[:assignment_id])
    @assignment.update(unassignment_params)
    render json: @assignment
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vehicle
      @vehicle = Vehicle.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def vehicle_params
      params.require(:vehicle).permit(:make, :model, :manufacture_year, :color, :image, :plate_number, :engine_number, :fuel_type)
    end

    # Only allow a trusted parameter "white list" through.
    def assignment_params
      params.require(:assignment).permit(:driver_id, :start_date, :start_odometer, :comment)
    end

    # Only allow a trusted parameter "white list" through.
    def unassignment_params
      params.require(:assignment).permit(:end_odometer, :end_date, :comment)
    end
end
