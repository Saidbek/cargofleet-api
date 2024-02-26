class API::IssuesController < API::BaseController
  api :GET, '/issues', 'Retrieve a list of issues of a vehicle'
  param :description, String, desc: 'Filter by description (optional)'
  param :page, String, desc: 'Page number for pagination (optional)'
  param :per_page, String, desc: 'Number of records per page (optional)'

  def index
    @vehicle = Vehicle.find(params[:vehicle_id])
    @issues = @vehicle.issues
    @issues = sort_and_filter(@issues, filter_columns: [:description])
    @issues = paginate_query(@issues, params)

    render_paginated_response @issues
  end

  api :POST, '/vehicles/:vehicle_id/issues', "Create a new vehicle's issue"
  param :vehicle_id, :number, desc: 'ID of the associated vehicle'
  param :description, String, desc: 'Description of the issue'
  param :priority, String, desc: 'Priority of the issue'
  param :due_date, String, desc: 'Due date of the issue'

  def create
    @issue = Issue.new(issue_create_params)

    if @issue.save
      render json: @issue, status: :created
    else
      render json: @issue.errors, status: :unprocessable_entity
    end
  end

  api :DELETE, '/vehicles/:vehicle_id/issues/:id', 'Delete an issue by ID'
  param :vehicle_id, :number, desc: 'ID of the associated vehicle'
  param :id, :number, required: true, desc: 'ID of the issue to delete'

  def destroy
    @vehicle = Vehicle.find(params[:vehicle_id])
    @issue = @vehicle.issues.find(params[:id])
    @issue.destroy
  end

  api :PATCH, '/vehicles/:vehicle_id/issues/:id/complete', "Complete an issue"
  param :vehicle, :number, desc: 'ID of the associated vehicle'
  param :id, :number, desc: 'ID of the associated issue'
  def complete
    @vehicle = Vehicle.find(params[:vehicle_id])
    @issue = @vehicle.issues.find(params[:issue_id])
    if @issue.update(completed: true)
      render json: @issue, status: :no_content
    else
      render json: @issue.errors, status: :unprocessable_entity
    end
  end

  private

  def issue_create_params
    params.permit(:vehicle_id, :description, :priority, :due_date)
  end
end