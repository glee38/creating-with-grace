class CommentsController < ApplicationController
  before_action :set_post, only: [:create, :edit, :update, :destroy]
  def new
  end

  def create
    @comment = @post.comments.build(comment_params)
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
  end

  def destroy 
    @comment = Comment.find(params[:id])
    @comment.destroy

    flash[:notice] = "Comment was successfully deleted."
    redirect_to post_path(@post)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

end
