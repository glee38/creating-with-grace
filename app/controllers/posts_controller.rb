class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
    @post.build_art_medium
  end

  def create
    @post = Post.new(post_params)
    raise post_params.inspect
    if @post.save
      flash[:notice] = "Post was successfully created."
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :art_medium_id, :all_categories, :category_ids => [], art_medium_attributes: [:name])
  end
end
