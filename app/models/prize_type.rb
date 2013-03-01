# encoding: utf-8

class PrizeType < ActiveRecord::Base
  
  has_many :task_prizes, dependent: :delete_all
  has_many :tasks, through: :task_prizes

  mount_uploader :image, PrizeImageUploader

  attr_accessible :name, :segregate, :image, :is_free

  validates :name,    presence: true, length: { in: 2..100 }, uniqueness: { with: true, case_sensitive: false }
  validates :is_free, inclusion: { in: [true, false] }

  scope :segregated,     where(segregate: true)
  scope :not_segregated, where(segregate: false)

  scope :free, where(is_free: true)
  scope :paid, where(is_free: false)
end
