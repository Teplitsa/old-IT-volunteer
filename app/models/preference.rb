class Preference < ActiveRecord::Base
  belongs_to :user
  belongs_to :preferenceble, polymorphic: true

  validates :user, :preferenceble, presence: true, associated: true

  scope :prefer, ->(o) { where(preferenceble_id: o.id, preferenceble_type: o.class.name) }
end