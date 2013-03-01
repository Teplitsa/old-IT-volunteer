# encoding: utf-8

class Comment < ActiveRecord::Base
  include ActsAsTree

  acts_as_tree

  attr_accessible :body, :parent_id, :organization_id

  belongs_to :commentable, polymorphic: true
  belongs_to :owner, class_name: 'User'
  belongs_to :organization, class_name: 'Organization'
  
  validates :commentable, :owner, presence: true, associated: true
  validates :body, presence: true, length: { in: 2..1488 }
  validates :organization, associated: true

  validate :check_representative

  after_create :make_comment_event

  def commenter
    organization || owner
  end

  private

  def check_representative
    if self.organization_id and !owner.all_organizations.include?(self.organization)
      errors.add(:organization, 'Representative only!')
    end
  end

  def make_comment_event
    CommentEvent.create(user: owner, actor: self, target: commentable)
  end
end
