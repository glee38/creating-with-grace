class CommentsController < ApplicationController
  def new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    
    if @comment.save
      flash[:notice] = "Comment was successfully added."
      redirect_to post_path(@post)
    else
      flash[:alert] = "Comment could not be added: content cannot be blank."
      render template: 'posts/show' 
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end
