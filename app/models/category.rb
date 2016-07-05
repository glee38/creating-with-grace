class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :post_categories
  has_many :posts, through: :post_categories

  validates_presence_of :name
  validates_uniqueness_of :name

  def self.list_categories
    self.uniq.pluck(:name)
  end

end
