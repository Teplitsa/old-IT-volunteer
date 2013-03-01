# encoding: utf-8

class TaskType < ActiveRecord::Base

  has_many :tasks

  mount_uploader :image, TaskTypeImageUploader

  attr_accessible :name, :image

  validates :name,  presence: true, length: { in: 3..100 }, uniqueness: { with: true, case_sensitive: false }
  
end