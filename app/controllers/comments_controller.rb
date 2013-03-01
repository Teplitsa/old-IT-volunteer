class CommentsController < InheritedResources::Base

  before_filter :authenticate_user!
  
  load_and_authorize_resource

  respond_to :js, :json

  belongs_to :task, :organization, :user, polymorphic: true

  actions :new, :create, :destroy

  helper_method :parent_comment

  def index
  end

  def create
    authorize! :create, @comment

    create! do |success, failure|
      success.html { redirect_to parent_path(parent)}
      failure.html { redirect_to parent_path(parent)}
    end
  end

  def parent_comment
    @parent_comment ||= end_of_association_chain.find(params[:parent_id]) rescue nil
  end

  def build_resource
    @comment ||= end_of_association_chain.new(params[:comment])
    @comment.owner = current_user
    @comment.parent = parent_comment if parent_comment
    @comment
  end

end
