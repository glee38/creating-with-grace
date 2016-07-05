class Profile < ActiveRecord::Base
  extend FriendlyId
  friendly_id :username, use: [:slugged]

  belongs_to :user
  mount_uploader :avatar, AvatarUploader
end
