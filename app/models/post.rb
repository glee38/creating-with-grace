class Post < ActiveRecord::Base
  belongs_to :user # admin only
  belongs_to :art_medium
  has_many :videos # admin only
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :comments
  has_many :commenters, through: :comments, :source => :user
  has_many :images
  has_many :image_uploaders, through: :images, :source => :user

  accepts_nested_attributes_for :art_medium, reject_if: :all_blank

  def all_categories=(names)
    self.categories = names.split(",").map do |name|
        Category.where(name: name.strip).first_or_create!
    end
  end

  def all_categories
    self.categories.map(&:name).join(", ")
  end

end
