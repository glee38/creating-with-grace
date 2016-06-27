class ArtMedium < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :posts
  validates_uniqueness_of :name
end
