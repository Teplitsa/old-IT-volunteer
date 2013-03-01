# encoding: utf-8

class TasksController <  InheritedResources::Base
  respond_to :js, only: [:apply, :assign]

  before_filter :authenticate_user!, except: [:index, :show]

  load_and_authorize_resource

  #belongs_to :user, :organization, :optional => true
  has_scope :page, :default => 1

  def current_search_path
    @current_search_path ||= tasks_path
  end

  def index
    authorize! :index, Task

    @tasks = Task.includes(:comments).published.active.recent.search(params)
  end

  def show
    @users = @task.users.group_by{|u|u.roles.first.name}.sort{|a,b| b<=>a}
    @events = @task.events.order("created_at ASC")
  end

  def new
    @organizations = current_user.all_organizations
    new!
  end

  def edit
    @organizations = current_user.all_organizations
    edit!
  end

  def create # WTF?
    authorize! :build, @task
    create!
  end

  def assign
    user = User.find(params[:user_id])
    
    if @task.user_role(user) && @task.user_role(user).name == 'volunteer'
      flash[:warning] = t("user.already_assigned", user: user.full_name)
    else
      user.add_role :volunteer, @task
      user.revoke :applicant, @task
      @task.fire_state_event :perform if @task.opened?
      flash[:notice] = t("user.assigned", user: user.full_name)
    end

    respond_with(@task) do |format|
      format.html {redirect_to(@task)}
    end
  end

  def apply
    if @task.user_role(current_user)
      flash[:warning] = t('user.already_aplied')
    else
      current_user.add_role :applicant, @task
    end

    respond_with(@task) do |format|
      format.html {redirect_to(@task)}
    end
  end

  Task::ROLES.each do |role|
    define_method "kick_#{role}" do
      user = User.find(params[:user_id])
      user_role = user.remove_role(role, @task)

      flash[:notice] = t("user.removed", 
        user: user.full_name,
        role: t("role.of_#{role.to_s.pluralize}")
      ) if user_role.present?

      redirect_to @task
    end
  end

  def feedback
    feedback = @task.feedbacks.create(params[:task])
    
    if feedback.save
      flash[:notice] = "Спасибо за Ваш отзыв!"
    else
      flash[:error] = feedback.errors.map { |attr, msg| msg }.join(' ')
    end

    redirect_to @task
  end

  def change_state
    begin
      @task.fire_state_event params[:state]
    rescue IndexError => e
      flash[:error] = "#{e.message}"
    else
      if @task.errors.any?
        flash[:error] = @task.errors.full_messages.join('\n')
      end
    end

    redirect_to @task
  end

  def build_resource
    @task ||= end_of_association_chain.new(params[:task])
    @task.owner = current_user
    @task
  end
  
end
