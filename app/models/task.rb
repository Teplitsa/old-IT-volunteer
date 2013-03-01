# encoding: utf-8

class Task < ActiveRecord::Base
  ROLES = [:applicant, :volunteer]
  STATES = { :reopen => { :value => 1, :state => :opened },
               :perform => { :value => 2, :state => :in_progress },
               :close => { :value => 3, :state => :closed }
              }
  resourcify
  paginates_per 6
  belongs_to :task_type
  belongs_to :owner,       class_name: 'User'
  belongs_to :organization

  has_many :task_prizes, dependent: :delete_all
  has_many :prize_types, through: :task_prizes

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :feedbacks
  has_many :events, as: :target, dependent: :delete_all

  # FILE UPLOAD #########

  mount_uploader :image, TaskImageUploader
  mount_uploader :file,  TaskFileUploader

  attr_accessible :title, :problem, :task_prizes, :deadline,
                  :task_type_id, :image, :file, :organization_id

  attr_accessor :user_id, :value, :body

  # VALIDATIONS #########

  validates :task_type, :organization, associated: true
  validates :task_type, presence: true
  validates :title,     presence: true, length: { in: 2..50 }
  validates :problem,   presence: true, length: { in: 10..300 }
  validates :deadline,  timeliness: { after: lambda{ Date.current + 1.day},
                                      type: :date, allow_blank: true, on: :create}

  validate :check_representative

  def check_representative
    if self.organization_id and !owner.all_organizations.include?(self.organization)
      errors.add(:organization, 'Необходимы права представителя!')
    end
  end

  scope :published, where('tasks.state < 4')
  scope :active, where('tasks.state < 3')
  scope :state, lambda {|st| where(:state => st)}

  scope :with_prize_type_id,    lambda { |tid| joins("right join (#{ TaskPrize.with_prize_type_id(tid).to_sql }) A on A.task_id = tasks.id") }
  scope :without_prize_type_id, lambda { |tid| joins("right join (#{ TaskPrize.without_prize_type_id(tid).to_sql }) A on A.task_id = tasks.id") }

  scope :free, where(is_free: true)
  scope :paid, where(is_free: false)
  scope :recent, order('created_at DESC')
  
  before_save :recalculate_paid
  after_create -> { make_task_event("created") }
  after_update -> { make_task_event("updated") unless self.state_changed? }

  # STATES #########

  state_machine :initial => :unpublished do
    state :opened,      value: 1
    state :in_progress, value: 2
    state :closed,      value: 3
    state :unpublished, value: 4
    state :deleted, value: 5

    event :reopen do
      transition all - [:opened, :unpublished, :deleted] => :opened
    end

    event :perform do
      transition :opened => :in_progress
    end

    event :close do
      transition all - [:closed, :unpublished, :deleted] => :closed
    end

    event :publish do
      transition :unpublished => :opened
    end

    event :delete_task do
      transition any => :deleted
    end

    after_transition any - [:unpublished, :deleted] => :closed do |task, trans|
      task.make_task_event("closed")
    end

    after_transition any - [:deleted] => :opened do |task, trans|
      task.make_task_event("opened")
    end

  end

  # INDEXING #########

  define_index do
    indexes :title
    indexes :problem

    has :state,        as: :state
    has :task_type_id, as: :types, type: :integer
    has :is_free,  type: :boolean

    has task_prizes.prize_type_id, as: :prizes
  end

  def self.search(params)
    page_num = (params[:page] || 1).to_i
    query = params[:text]

    filters = [:types, :prizes, :state].inject({}) do |a,o|
      a[o] = params[o] if params[o].present?; a
    end
    if query or filters.any?
      filters[:is_free] = (params[:is_free] == 't') if params[:is_free].present?
      super(query, with: filters, without: { state: [4, 5] }, page: page_num, per_page: 4, match_mode: :any)
    else
      result = page(page_num).per(4)

      if params[:is_free].present?
        result = (params[:is_free] == 't' ? result.free : result.paid) 
      end
      
      result
    end
  end

  def task_prizes=(params)
    task_prizes.delete_all
    params.reject { |p| p['prize_type_id'].nil? }.each { |params| task_prizes << TaskPrize.new(params) }
  end

  def user_role(user)
    role = self.roles.joins(:users).where('users.id' => user.id).first
    return role || false
  end

  def recalculate_paid
    self.is_free = self.task_prizes.all?{|type| type.prize_type.is_free }
    true
  end

  def users
    User.includes(:roles).where('roles.resource_type' => 'Task', 'roles.resource_id' => id)
  end

  ROLES.each do |role|
    define_method role.to_s.pluralize do
      users.where('roles.name' => role)
    end
  end

  def make_task_event(msg)
    TaskEvent.create(actor: self, user: owner, target: self, message: msg)
  end
end


