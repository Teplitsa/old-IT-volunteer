class HomeController < ApplicationController
  def index
    @users = User.ratings.limit(3)
    @free_tasks = Task.published.free.recent.limit(3)
    @paid_tasks = Task.published.paid.recent.limit(3)
    @recent_tasks = Task.published.recent.where('tasks.organization_id is not null').limit(3)
  end
end
