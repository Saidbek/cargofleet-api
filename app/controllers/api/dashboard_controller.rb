class API::DashboardController < API::BaseController
  def index
    {
      issues: {
        open: "",
        overdue: ""
      },
      drivers: {
        active: "",
        archived: ""
      },
      vehicles: {
        assigned: "",
        unassigned: "",
        active: "",
        archived: ""
      }
    }
  end
end
