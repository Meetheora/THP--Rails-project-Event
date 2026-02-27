class Admin::DashboardController < Admin::BaseController
  def index
  @users_count = User.count
  @events_count = Event.count
  @pending_events = Event.where(validated: false).count
  end
end
