class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  validates_presence_of :content

  def pretty_created_at
    created_at.strftime("%b %d, %Y")
  end
end
