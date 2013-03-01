require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  helper_method :current_search_path

  def current_admin
    current_user.try(:admin?) ? current_user : nil
  end

  def authenticate_admin_user!
    fail SecurityError unless current_admin
  end

  def require_user
    unless current_user
      flash[:alert] = "You must be logged in to access this page"
      redirect_to root_url
    end
  end

  def require_no_user
    if current_user
      flash[:alert] = "You must be logged out to access this page"
      redirect_to root_url
    end
  end

  def page_not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = t("none.access")
    redirect_to root_url
  end

  rescue_from(SecurityError) do |exception|
    flash[:error] = t("none.access")
    redirect_to root_url 
  end

  rescue_from(ActiveRecord::RecordNotFound)       { |exception| page_not_found }
  rescue_from(AbstractController::ActionNotFound) { |exception| page_not_found }

end
