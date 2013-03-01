class Event < ActiveRecord::Base
  attr_accessible :user, :actor, :target, :action, :message

  belongs_to :actor,  polymorphic: true
  belongs_to :target, polymorphic: true
  belongs_to :user

  validates_presence_of :user, :target
end
