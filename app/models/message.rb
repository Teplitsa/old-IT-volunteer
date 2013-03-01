class Message < ActiveRecord::Base
  
  belongs_to :receiver, class_name: 'User', foreign_key: :receiver_id
  belongs_to :sender,   class_name: 'User', foreign_key: :sender_id

  attr_accessible :body, :dialog_id, :receiver_id

  validates :receiver, :sender, presence: true, associated: true
  validates :body, presence: true, length: { in: 1..500 }

  scope :roots,     where('id = dialog_id')
  scope :dialog,    ->(dialog_id) { where(dialog_id: dialog_id) }
  scope :with_user, ->(user)      { where('((receiver_id = ?) or (sender_id = ?))', user.id, user.id) }

  after_save :create_dialog!, if: proc{ |m| m.dialog_id.nil? }

  private

  def create_dialog!
    update_attribute(:dialog_id, self.id)
  end
end
