# encoding: utf-8

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    
    alias_action :reopen, :perform, :close, :to => :change_state

    if user.has_role? :admin
      can :manage, :all # убрать!
    end

    # user
    can :manage, User do |u|
      u == user
    end
    
    # task
    can :read,  Task do |task|
      !task.deleted? && (!task.unpublished? || user.id == task.owner_id)
    end

    can :create, Task unless user.new_record?
    
    if not user.new_record?
      can :comment, Task

      can :apply, Task do |task|
        task.owner_id != user.id
      end
    end

    can [:build, :feedback], Task do |t|
      user.owner?(t.organization) || user.has_role?(:representative, t.organization)
    end
    
    can [:assign, :change_state], Task do |task|
      !task.deleted? && !task.unpublished? && task.owner_id == user.id
    end

    Task::ROLES.each do |role|
      can "kick_#{role}".to_sym, Task do |task|
        !task.deleted? && !task.unpublished? && task.owner_id == user.id
      end
    end

    can  [:edit, :update, :publish], Task do |task|
      task.owner_id == user.id && !task.deleted?
    end

    # comment
    unless user.new_record?
      can :read, User
      can :create, Comment
      can :destroy, Comment do |comment|
        user.id == comment.owner_id
      end
    end

    # organization
    can :read, Organization
    can :read, Comment
    can [:build, :create], Organization unless user.new_record?
    
    Organization::ROLES.each do |role|
      can [:manage, :invite_user, "kick_#{role}".to_sym], Organization do |org|
        org.user_id == user.id
      end
    end

    # messages
    if not user.new_record?
      can :read, Message do |*messages|
        messages.flatten.all? do |message|
          (message.sender == user) || (message.receiver == user)
        end
      end

      can [:build, :create, :update, :edit], Message

      can :send_message, User do |receiver|
        !(user == receiver || receiver.ignored?(user) || user.ignored?(receiver))
      end
    end

  end
end
