class Page < ActiveRecord::Base
  attr_accessible :content, :slug, :title
  extend FriendlyId
  friendly_id :title, :use => :slugged
end
