class API::IssuesController < API::BaseController
  before_action :set_issue, only: [:show, :update, :destroy]

  # API Endpoint: /api/issues
  api :GET, '/issues', 'Retrieve a list of issues'
  param :title, String, desc: 'Filter by issue title (optional)'
  param :page, String, desc: 'Page number for pagination (optional)'
  param :per_page, String, desc: 'Number of records per page (optional)'

  # Description: This endpoint retrieves a paginated list of issues, optionally filtered by title.
  def index
    @issues = Issue.includes(:vehicle)
    @issues = sort_and_filter(@issues, filter_columns: [:title])
    @issues = paginate_query(@issues, params)

    # Response:
    #   - Content-Type: application/json
    #   - Body: JSON array containing a list of issues
    render_paginated_response @issues
  end

  # API Endpoint: /api/issues/:id
  api :GET, '/issues/:id', 'Retrieve a specific issue by ID'
  param :id, :number, required: true, desc: 'ID of the issue to retrieve'

  # Description: This endpoint retrieves a specific issue by ID.
  def show
    render json: @issue
  end

  # API Endpoint: /api/issues
  api :POST, '/issues', 'Create a new issue'
  param :vehicle_id, :number, desc: 'ID of the associated vehicle'
  param :title, String, desc: 'Title of the issue', required: true
  param :description, String, desc: 'Description of the issue'
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

  # API Endpoint: /api/issues/:id
  api :PATCH, '/issues/:id', 'Update an existing issue by ID'
  param :id, :number, required: true, desc: 'ID of the issue to update'
  param :title, String, desc: 'Title of the issue'
  param :description, String, desc: 'Description of the issue'
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

  # API Endpoint: /api/issues/:id
  api :DELETE, '/issues/:id', 'Delete an issue by ID'
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
