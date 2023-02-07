class API::DashboardController < API::BaseController
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
    render json: stats_response
  end
end
