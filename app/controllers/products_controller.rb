class ProductsController < ApplicationController
  has_many :reviews
  has_many :reviewers, through: :reviews, :source => :user
  has_many :product_details
  belongs_to :brand
end
