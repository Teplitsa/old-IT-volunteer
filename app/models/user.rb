# encoding: utf-8

class User < ActiveRecord::Base
  rolify after_add: :create_role_event, after_remove: :remove_role_event
  
  acts_as_taggable

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  has_many :authentications, dependent: :destroy
  has_many :tasks, foreign_key: :owner_id
  has_many :organizations
  has_many :feedbacks

  has_many :comments, foreign_key: :owner_id, class_name: 'Comment'
  has_many :received_comments, as: :commentable, class_name: 'Comment', dependent: :destroy

  has_many :send_messages,   class_name: 'Message', foreign_key: :sender_id
  has_many :receiv_messages, class_name: 'Message', foreign_key: :receiver_id

  has_many :preferences, class_name: 'Preference'

  # FILE UPLOAD #########

  mount_uploader :avatar, AvatarUploader

  # ATTRIBUTES

  attr_accessor :org_presenter, :accept_terms, :subscribe
  
  attr_accessible :first_name, :last_name, :avatar, :avatar_cache, 
                  :remote_avatar_url, :email, :sex, :about, 
                  :password, :password_confirmation, :remember_me, :tag_list,
                  :website, :skype, :facebook, :twitter, :linkedin,
                  :organizations_attributes, :org_presenter, :city,
                  :accept_terms, :subscribe

  accepts_nested_attributes_for :organizations

  # VALIDATIONS #########

  validates :first_name, :last_name, presence: true, length: { in: 2..15 }
  validates :about, length: { maximum: 300 }
  validates :city, :email, :website, :skype, :facebook, :twitter, :linkedin, length: { maximum: 30 }

  scope :ratings, order('rating ASC')

  # INDEXING #########

  define_index do
    indexes :first_name
    indexes :last_name
    indexes :about
  end

  def self.search(params)
    page_num = (params[:page] || 1).to_i
    query = params[:text]

    if query = params[:text]
      super(query, page: page_num, per_page: 4)
    else
      page(page_num).per(4)
    end
  end

  ### OTHER ##########

  def org_presenter=(v)
    @org_presenter = (v == '1')
  end

  before_validation do
    organizations.clear if new_record? and !self.org_presenter
  end

  def prefer!(obj)
    preferences.find_or_create_by_preferenceble_id_and_preferenceble_type(obj.id, obj.class.name)
  end

  def prefered?(obj)
    preferences.prefer(obj).exists?
  end

  def unprefer!(obj)
    preferences.prefer(obj).delete_all
  end

  def ignored_users_ids
    self[:ignored_users_ids] ||= []
  end

  def ignored_users
    @ignored_users ||= User.find(ignored_users_ids)
  end

  def ignored?(user)
    user.nil? ? false : ignored_users_ids.include?(user.id)
  end

  def ignore!(user)
    transaction do
      u = User.find_by_id(self.id)
      u.lock!
      u.ignored_users_ids += [user.id]
      u.save!
    end
  end

  def unignore!(user)
    transaction do
      u = User.find_by_id(self.id)
      u.lock!
      u.ignored_users_ids -= [user.id]
      u.save!
    end
  end

  def feedback(task_id)
    feedbacks.for_task(task_id)
  end

  def potential_collocutor
    User.where('id not in (SELECT unnest(ignored_users_ids) FROM users WHERE id = ?)', self.id) - [self]
  end

  def self.build_user_wo_confirmation(omniauth)
    user = User.new first_name: omniauth['info']['first_name'],
                    last_name: omniauth['info']['last_name'],
                    email: omniauth['info']['email'],
                    remote_avatar_url: omniauth['info']['image'] || '',
                    password: Devise.friendly_token
    user.confirm!
    return user
  end

  def apply_omniauth(omniauth)
    authentications.build(provider: omniauth['provider'], uid: omniauth['uid'])
  end

  def password_required?
    ( !password.blank? || authentications.empty?) && super
  end

  def full_name
    [self.first_name, self.last_name].join(' ')
  end

  def to_s
    full_name
  end

  def admin?
    has_role? :admin
  end

  def owner?(organization)
    organization.user_id == self.id if organization.present?
  end

  def all_organizations
    (self.organizations.verified + self.representative_in).uniq
  end

  Organization::ROLES.each do |role|
    define_method role.to_s+'_in' do
      Organization.verified.with_role role, self
    end
  end

  private

  def create_role_event(role)
    RoleEvent.create actor: role,
                    target: role.resource,
                      user: self,
                    action: :add,
                   message: role.name
  end

  def remove_role_event(role)
    RoleEvent.create actor: role,
                    target: role.resource,
                      user: self,
                    action: :remove,
                   message: role.name
  end

end
