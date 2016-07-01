class Post < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  acts_as_votable

  belongs_to :user # admin only
  belongs_to :art_medium
  has_many :videos # admin only
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :comments, dependent: :destroy
  has_many :commenters, through: :comments, :source => :user
  has_many :images, dependent: :destroy
  has_many :image_uploaders, through: :images, :source => :user

  mount_uploader :thumbnail, ThumbnailUploader

  validates_presence_of :title, :content

  accepts_nested_attributes_for :art_medium, allow_destroy: true

  # took :categories field out of form builder for posts to prevent multiple category fields from appearing

  # def categories_attributes=(hash)
  #   hash.each do |i, category_attributes|
  #     category_attributes.each do |name, value|
  #       value.split(",").map do |v|
  #         if v.present?
  #           category = Category.find_or_create_by(name: v.strip)
  #           self.categories << category
  #         end
  #       end
  #     end
  #   end
  # end

  def category=(hash)
    hash.each do |name, value|
      value.split(",").map do |v|
        if v.present?
          category = Category.find_or_create_by(name: v.strip)
          self.categories << category
        end
      end
    end
  end

  def art_medium_attributes=(hash)
      if hash[:_destroy] == "1"
        self.art_medium = nil
      elsif hash[:name].present?
        medium = ArtMedium.find_or_create_by(name: hash[:name])
        self.art_medium = medium
      end
  end

  def all_categories
    self.categories.map(&:name).join(", ")
  end

  def pretty_created_at
    created_at.strftime("%b %d, %Y")
  end

  def self.sort_by_date_asc
    self.select(:title, :id, :art_medium_id, :thumbnail, :created_at, :slug).order(:created_at => :asc)
  end

  def self.sort_by_date_desc
    self.select(:title, :id, :art_medium_id, :thumbnail, :created_at, :slug).order(:created_at => :desc)
  end

  def self.sort_options_array
    ["Categories", "Date ASC", "Date DESC", "Art Media", "Product Reviews"]
  end

  def previous_post
    Post.where(["id > ?", id]).first
  end

  def next_post
    Post.where(["id < ?", id]).last
  end

end
