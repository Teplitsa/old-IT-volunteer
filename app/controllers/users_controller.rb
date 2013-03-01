# encoding: utf-8
class UsersController < InheritedResources::Base
  
  before_filter :authenticate_user!
  
  load_and_authorize_resource
  
  has_scope :page, default: 1

  custom_actions resource: [:ignore, :unignore]

  def current_search_path
    @current_search_path ||= users_path
  end

  def index
    @users = User.search(params)
  end

  def show
    @tasks = @user.tasks.group_by(&:state)
  end

  def update
    successfully_updated = if want_to_change_password? or want_to_change_email?
      @user.update_with_password(params[:user])
    else
      @user.update_without_password(params[:user])
    end

    respond_to do |format|
      if successfully_updated
        # Sign in the user by passing validation in case his password changed
        sign_in @user, :bypass => true if want_to_change_password? and want_to_change_email?

        format.html { redirect_to @user}
        format.json { head :no_content } # 204 No Content
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def ignore
    current_user.ignore! @user
  end

  def unignore
    current_user.unignore! @user
  end

  private

  def want_to_change_password?
    @want_to_change_password ||= !params[:user][:password].empty? rescue false
  end

  def want_to_change_email?
    @want_to_change_email ||= params[:user][:email].present? and (@user.email != params[:user][:email]) rescue false
  end

end