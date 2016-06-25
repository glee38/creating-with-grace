class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :update, :edit, :destroy]

  def index
    @categories = Category.all
  end

  def show
  end

  private

  def set_category
    @category = Category.find_by_slug(params[:id])
  end
end
