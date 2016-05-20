class User < ActiveRecord::Base
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

end
