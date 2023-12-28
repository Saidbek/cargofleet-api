class API::IssuesController < API::BaseController
  api :POST, '/api/vehicles/:vehicle_id/issues', "Create a new vehicle's issue"
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

  api :DELETE, '/vehicles/:vehicle_id/issues/:id', 'Delete an issues by ID'
  param :vehicle_id, :number, desc: 'ID of the associated vehicle'
  param :id, :number, required: true, desc: 'ID of the issue to delete'

  def destroy
    @vehicle = Vehicle.find(params[:vehicle_id])
    @issue = @vehicle.issues.find(params[:id])
    @issue.destroy
  end

  private

  def issue_create_params
    params.permit(:vehicle_id, :description, :priority, :due_date)
  end
end