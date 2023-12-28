class API::TripsController < API::BaseController
  before_action :set_issue, only: [:show, :update, :destroy]

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

  # API Endpoint: /api/trips
  api :GET, '/trips', 'Retrieve a list of trips'
  param :title, String, desc: 'Filter by issue title (optional)'
  param :page, String, desc: 'Page number for pagination (optional)'
  param :per_page, String, desc: 'Number of records per page (optional)'

  # Description: This endpoint retrieves a paginated list of trips, optionally filtered by title.
  def index
    @trips = Issue.includes(:vehicle)
    @trips = sort_and_filter(@trips, filter_columns: [:title])
    @trips = paginate_query(@trips, params)

    # Response:
    #   - Content-Type: application/json
    #   - Body: JSON array containing a list of trips
    render_paginated_response @trips
  end

  # API Endpoint: /api/trips/:id
  api :GET, '/trips/:id', 'Retrieve a specific issue by ID'
  param :id, :number, required: true, desc: 'ID of the issue to retrieve'

  # Description: This endpoint retrieves a specific issue by ID.
  def show
    render json: @issue
  end

  # API Endpoint: /api/trips
  api :POST, '/trips', 'Create a new issue'
  param :vehicle_id, :number, desc: 'ID of the associated vehicle'
  param :title, String, desc: 'Title of the issue'
  param :description, String, allow_nil: true, desc: 'Description of the issue'
  param :priority, String, desc: 'Priority of the issue'
  param :due_date, String, desc: 'Due date of the issue'

  # Description: This endpoint creates a new issue.
  def create
    @issue = Issue.new(issue_create_params)

    if @issue.save
      # Response:
      #   - Content-Type: application/json
      #   - Body: JSON object representing the created issue
      render json: @issue, status: :created
    else
      # Response:
      #   - Content-Type: application/json
      #   - Body: JSON object containing validation errors
      render json: @issue.errors, status: :unprocessable_entity
    end
  end

  # API Endpoint: /api/trips/:id
  api :PATCH, '/trips/:id', 'Update an existing issue by ID'
  param :id, :number, required: true, desc: 'ID of the issue to update'
  param :title, String, desc: 'Title of the issue'
  param :description, String, allow_nil: true, desc: 'Description of the issue'
  param :priority, String, desc: 'Priority of the issue'
  param :due_date, String, desc: 'Due date of the issue'

  # Description: This endpoint updates an existing issue by ID.
  def update
    if @issue.update(issue_update_params)
      render json: @issue
    else
      render json: @issue.errors, status: :unprocessable_entity
    end
  end

  # API Endpoint: /api/trips/:id
  api :DELETE, '/trips/:id', 'Delete an issue by ID'
  param :id, :number, required: true, desc: 'ID of the issue to delete'

  # Description: This endpoint deletes an issue by ID.
  def destroy
    @issue.destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_issue
    @issue = Issue.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through for create action.
  def issue_create_params
    params.permit(:vehicle_id, :title, :description, :priority, :due_date)
  end

  # Only allow a trusted parameter "white list" through for update action.
  def issue_update_params
    params.permit(:title, :description, :priority, :due_date)
  end
end
