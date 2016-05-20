class Post < ActiveRecord::Base
  belongs_to a :user # admin only
  has_many :videos # admin only
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :comments
  has_many :commenters, through: :comments, :source => :user
  has_many :images
  has_many :image_uploaders, through: :images, :source => :user
end
