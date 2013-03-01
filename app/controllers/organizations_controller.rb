# encoding: utf-8

class OrganizationsController < InheritedResources::Base
  before_filter :authenticate_user!
  load_and_authorize_resource
  respond_to :html

  def current_search_path
    @current_search_path ||= organizations_path
  end

  def index
    @organizations = Organization.search(params)
  end

  def show
    page_not_found unless @organization.verified?
    @users = @organization.users
             .group_by{|u|u.roles.first.name}.sort{ |a,b| b <=> a }
    @tasks = @organization.tasks.group_by(&:state)
  end

  def create
    create! do |s,f|
      s.html { redirect_to organizations_path }
    end
  end

  def update
    update! do |format|
      format.html { redirect_to resource, notice:  'Updated' }
      format.json { head :no_content }

      format.html { render action: "edit" }
      format.json { render json: resource.errors, status: :unprocessable_entity }
    end
  end

  def invite_user
    if params[:organization][:user_email].present? && params[:organization][:role].present?
      user = User.find_by_email(params[:organization][:user_email])

      if user.nil?
        flash[:warning] = t('none.user.with_email', :email => params[:organization][:user_email])
      else
        role = user.add_role params[:organization][:role], @organization if Organization::ROLES.include? params[:organization][:role].to_sym
        flash[:notice] = t('org.user_added', :user => user.full_name, :role => t("role.as_#{role.name}"))
      end
    else
      flash[:error] = t('org.wrong_user')
    end
    redirect_to @organization
  end

  Organization::ROLES.each do |role|
    define_method "kick_#{role}" do
      user = User.find(params[:user_id])
      user_role = user.remove_role(role, @organization)

      flash[:notice] = t("user.removed", 
        :user => user.full_name,
        :role => t("role.of_#{role.to_s.pluralize}")
      ) if user_role.present?
      
      redirect_to @organization
    end
  end

  private
  def build_resource
    organization = params[:organization]
    @organization ||= end_of_association_chain.new(organization)
    @organization.user = current_user
    @organization.verified = false
    @organization
  end

end
