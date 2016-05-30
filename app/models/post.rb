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

  mount_uploader :thumbnail, ThumbnailUploader

  accepts_nested_attributes_for :art_medium, reject_if: :all_blank

  validates_presence_of :title, :content

  def categories_attributes=(hash)
    hash.each do |i, category_attributes|
      category_attributes.each do |name, value|
        value.split(",").map do |v|
          if v.present?
            category = Category.find_or_create_by(name: v.strip)
            self.categories << category
          end
        end
      end
    end
  end

  def all_categories
    self.categories.map(&:name).join(", ")
  end

end
