# encoding: utf-8

class Authentication < ActiveRecord::Base
  belongs_to :user
  
  attr_accessible :provider, :uid

  validates :provider, presence: true
  validates :uid,      presence: true, uniqueness: { with: true, case_sensitive: false, scope: [:provider] }
end