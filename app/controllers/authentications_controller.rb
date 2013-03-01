class AuthenticationsController < InheritedResources::Base
  before_filter :authenticate_user!
  load_and_authorize_resource
  respond_to :js, :json
end