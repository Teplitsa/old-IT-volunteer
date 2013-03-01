# encoding: utf-8

class TaskPrize < ActiveRecord::Base
  belongs_to :task
  belongs_to :prize_type

  attr_accessible :count, :prize_type_id

  validates_associated :prize_type
  
  validates :prize_type, presence: true

  before_save { self.count = nil if prize_type and prize_type.segregate }

  scope :without_prize_type_id, lambda{ |tid| select('DISTINCT task_id').where("task_prizes.task_id not in (#{select(:task_id).by_prize_type_id(tid).to_sql})") }
  scope :with_prize_type_id,    lambda{ |tid| select('DISTINCT task_id').where("task_prizes.task_id in (#{select(:task_id).by_prize_type_id(tid).to_sql})") }
  
  scope :by_prize_type_id, lambda{ |tid| where(prize_type_id: tid) }
end
