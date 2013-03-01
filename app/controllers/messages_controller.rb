# encoding: utf-8

class MessagesController < InheritedResources::Base
  respond_to :js, only: [:new, :create]

  before_filter :authenticate_user!

  load_and_authorize_resource only: [:new, :create, :update, :destroy]

  actions :all, except: [:index]

  layout false, only: [:new]

  def dialogs
    @dialogs = collection.roots
    authorize! :read, *@dialogs if @dialogs.any?
  end

  def index
    @messages = collection.dialog(params[:dialog_id])
    authorize! :read, *@messages
  end

  def create
    create! do |success, failure|
      success.html { redirect_to dialog_path(@message.dialog_id) }
    end
  end

  def collection
    Message.with_user(current_user)
  end

  def build_resource
    @message ||= end_of_association_chain.new(params[:message])
    @message.sender = current_user
    @message
  end

end