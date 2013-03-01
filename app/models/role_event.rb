class RoleEvent < Event
  validates_presence_of :message, :action
end
