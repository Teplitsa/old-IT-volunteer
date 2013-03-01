class Feedback < ActiveRecord::Base
  belongs_to :user

  attr_accessible :body, :value, :user_id, :task_id

  validates :task_id, uniqueness: { scope:  :user_id, message: "Can't give feedback for the same user." }
  validates :body, presence: { message: "Can't give feedback without message." }

  scope :for_task, lambda { |task_id| where(task_id: task_id) }

  after_create :recalculate_user_rating

  private 

  def recalculate_user_rating
    user.rating += 1#self.value
    user.save!
  end
end
