class User < ActiveRecord::Base
  # mount_uploader :avatar, AvatarUploader # add this in later

  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable, :omniauthable

  enum role: [:admin, :moderator, :member]

  has_many :posts # admin only
  has_many :comments
  has_many :commented_posts, through: :comments, :source => :post
  has_many :reviews
  has_many :reviewed_products, through: :reviews, :source => :product
  has_many :videos # admin only
  has_many :uploaded_images, :source => :image
  has_one :profile # member only

  # validates_presence_of   :avatar
  # validates_integrity_of  :avatar
  # validates_processing_of :avatar

end
