class CommentsController < ApplicationController
  before_action :set_post, only: [:create, :edit, :update, :destroy]
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :authorize_comment, only: [:edit, :update, :destroy]
  respond_to :html, :json

  def new
    @comment = Comment.new
    authorize @comment
  end

  def create
    @comment = @post.comments.build(comment_params)
    authorize @comment
    @comment.commenter = current_user
    
    if @comment.save
      flash[:notice] = "Comment was successfully added."
      redirect_to post_path(@post)
    else
      flash[:alert] = "Comment could not be added: Content cannot be blank."
      render template: 'posts/show' 
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      flash[:notice] = "Comment was successfully updated."
      redirect_to post_path(@post)
    else
      flash[:alert] = "Comment could not be updated: Content cannot be blank."
      render template: 'posts/show'
    end
  end

  def destroy 
    @comment.destroy

    flash[:notice] = "Comment was successfully deleted."
    redirect_to post_path(@post)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_post
    @post = Post.find_by_slug(params[:post_id])
  end

  def authorize_comment
    authorize @comment
  end

end
