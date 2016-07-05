class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :username, use: :slugged

  acts_as_voter

  validates_format_of :username, with: /\A[a-zA-Z0-9._]+\Z/, :allow_blank => true
  validates :name, :username, presence: true, if: :active?
  
  mount_uploader :avatar, AvatarUploader
  # validates_presence_of   :avatar
  # validates_integrity_of  :avatar
  # validates_processing_of :avatar

  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable, :omniauthable

  enum role: [:admin, :moderator, :member]

  after_initialize :set_default_role, :if => :new_record?

  has_many :posts # admin only
  has_many :comments
  has_many :commented_posts, through: :comments, :source => :post
  has_many :reviews
  has_many :reviewed_products, through: :reviews, :source => :product
  has_many :videos # admin only
  has_many :uploaded_images, :source => :image
  has_one :profile, dependent: :destroy # member only

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid, email: auth.info.email).first_or_create do |user|
      user.email = auth.info.email
      user.provider = auth.provider
      user.uid = auth.uid
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end

  def active?
    status == 'active'
  end

  private
  def set_default_role
    self.role ||= :member
  end

end
