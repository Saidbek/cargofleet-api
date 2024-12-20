class API::DashboardController < API::BaseController
  # API Endpoint: /api/dashboard
  api :GET, '/dashboard', 'Retrieve statistics for the dashboard'

  returns code: 200, desc: 'A JSON object with counts of various entities' do
    property :drivers, Hash, desc: 'Drivers' do
      property :total, Integer, desc: 'Total number of drivers'
      property :active, Integer, desc: 'Number of active drivers (drivers with at least one trip)'
      property :inactive, Integer, desc: 'Number of inactive drivers (drivers with no trips)'
    end
    property :vehicles, Hash, desc: 'Vehicles' do
      property :assigned, Integer, desc: 'Number of assigned vehicles (vehicles with at least one trip)'
      property :unassigned, Integer, desc: 'Number of unassigned vehicles (vehicles with no trips)'
      property :active, Integer, desc: 'Number of active vehicles'
      property :inactive, Integer, desc: 'Number of inactive vehicles'
    end
    property :issues, Hash, desc: 'Issues' do
      property :open, Integer, desc: 'Number of open issues (issues not completed)'
      property :completed, Integer, desc: 'Number of completed issues'
      property :completed_by_priority, Array, desc: 'Number of completed issues by priority.
        The array is ordered by priority: [low, medium, high] where the index 0 is low, index 1 is medium, 
        and index 2 is high number of completed issues'
    end
    property :trips, Hash, desc: 'Trips' do
      property :completed, Integer, desc: 'Number of completed trips'
      property :ongoing, Integer, desc: 'Number of ongoing trips (trips not marked as completed)'
      property :last_30_days, Integer, desc: 'Number of trips in the last 30 days'
      property :monthly_completed, Array, desc: 'Number of trips completed by month'
    end
  end

  def index
    render json: {
      drivers: {
        active: Driver.active_count,
        inactive: Driver.inactive_count
      },
      vehicles: {
        assigned: Vehicle.assigned_count,
        unassigned: Vehicle.unassigned_count,
        active: Vehicle.active_count,
        inactive: Vehicle.inactive_count
      },
      issues: {
        open: Issue.open_count,
        overdue: Issue.overdue_count,
        completed_by_priority: Issue.completed_by_priority_counts,
      },
      trips: {
        completed: Trip.completed_count,
        ongoing: Trip.ongoing_count,
        last_30_days: Trip.last_30_days_count,
        monthly_completed: Trip.completed_by_month
      }
    }
  end
end
