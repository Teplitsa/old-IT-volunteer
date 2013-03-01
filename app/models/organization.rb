# encoding: utf-8

class Organization < ActiveRecord::Base
  ROLES = [:representative, :member]
  extend FriendlyId
  resourcify
  acts_as_taggable
  friendly_id :name, use: :slugged

  belongs_to :user
  has_many :tasks,     dependent: :destroy
  has_many :feedbacks, dependent: :delete_all
  
  # FILE UPLOAD #########
  
  mount_uploader :logo, LogoUploader
  
  attr_accessible :name, :about, :address, :logo, :logo_cache,
                  :website, :email, :skype, :twitter,
                  :facebook, :linkedin, :tag_list

  alias :avatar :logo
  
  def full_name
    self.name
  end

  attr_accessor :user_email, :role

  # VALIDATIONS #########
  
  validates :address, presence: true, length: { in: 10..100 }
  validates :website, website: true
  validates :name,    presence: true, length: { in: 3..100 }, 
                    uniqueness: { with: true, case_sensitive: false }

  scope :verified, where(verified: true)

  # INDEXING #########

  define_index do
    indexes :name
    indexes :about
    indexes :website
    indexes :skype
    indexes :twitter
    indexes :facebook
    indexes :linkedin

    has :verified,  type: :boolean
    # has :tag_list
  end

  def self.search(params)
    page_num = (params[:page] || 1).to_i
    query = params[:text]

    filters = [:is_group].inject({}) do |a,o|
      a[o] = params[o] if params[o].present?; a
    end

    if query or filters.any?
      filters[:verified] = true
      super(query, with: filters, page: page_num, per_page: 4)
    else
      verified.page(page_num).per(4)
    end
  end

  def verify!
    self.verified = true
    save!
  end

  def unverify!
    self.verified = false
    save!
  end

  def users
    User.includes(:roles).where('roles.resource_type' => 'Organization', 'roles.resource_id' => id)
  end

  def representatives
    users.where('roles.name' => 'representative')
  end

  def members
    users.where('roles.name' => 'member')
  end

end