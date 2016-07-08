class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :upvote]
  before_action :set_all_posts, only: [:index, :date_asc, :date_desc]
  before_action :authorize_post, only: [:edit, :update, :destroy]
  #before_action :more_than_one_medium, only: [:create, :update]

  def index
  end

  def new
    @post = Post.new
    authorize @post
    @post.categories.build
    @post.build_art_medium
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.categories.build

    if @post.save
      flash[:notice] = "Post was successfully created."
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
  end

  def edit
    if @post.art_medium.nil?
      @post.build_art_medium
    end
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "Post was successfully updated."
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

   def destroy 
    @post.destroy
    flash[:notice] = "Post was successfully deleted."
    redirect_to posts_path
  end

  def date_asc
  end

  def date_desc
  end

  def upvote
    @post.upvote_by current_user
    redirect_to :back
  end

  private

  def set_post
    @post = Post.find_by_slug(params[:id])
  end

  def set_all_posts
    @posts = Post.all
  end

  def post_params
    params.require(:post).permit(:title, :content, :art_medium_id, :thumbnail, :remove_thumbnail, category: [:name], :category_ids => [], art_medium_attributes: [:name, :_destroy])
  end

  def authorize_post
    authorize @post
  end

  # def more_than_one_medium
  #   if post_params[:art_medium_id] && post_params[:art_medium_attributes][:name]
  #     flash[:alert] = "Post can only have one medium."
  #     render :edit
  #   end
  # end
end
