class API::DashboardController < API::BaseController
  # API Endpoint: /api/dashboard
  api :GET, '/dashboard', 'Retrieve statistics for the dashboard'

  # Description: This endpoint provides statistics for the dashboard,
  # including counts of open and overdue issues, active and archived drivers,
  # and counts of assigned, unassigned, active, and archived vehicles.
  def index
    stats_response = {
      issues: {
        open: Issue.cached_open_count,
        overdue: Issue.cached_overdue_count
      },
      drivers: {
        active: Driver.cached_active_count,
        archived: Driver.cached_archived_count
      },
      vehicles: {
        assigned: Vehicle.cached_assigned_count,
        unassigned: Vehicle.cached_unassigned_count,
        active: Vehicle.cached_active_count,
        archived: Vehicle.cached_archived_count
      }
    }

    # Response:
    #   - Content-Type: application/json
    #   - Body: JSON object containing dashboard statistics
    render json: stats_response
  end
end
