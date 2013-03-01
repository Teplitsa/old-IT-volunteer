class PreferencesController < ApplicationController
  respond_to :js

  before_filter :authenticate_user!

  def prefer
    current_user.prefer!(resource)
  end

  def unprefer
    current_user.unprefer!(resource)
  end

  private 

  def resource
    @resource ||= if params[:task_type_id].present?
      TaskType.find(params[:task_type_id])
    elsif params[:prize_type_id].present?
      PrizeType.find(params[:prize_type_id])
    end
  end

end
