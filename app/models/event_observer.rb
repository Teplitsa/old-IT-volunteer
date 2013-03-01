class EventObserver < ActiveRecord::Observer

  def after_create(event)
    TaskMailer.updates(event).deliver
  end
end