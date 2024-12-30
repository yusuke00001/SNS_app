class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:notice] = t('flash.comments.create.success')
      redirect_to post_path(@post)
    else
      flash.now[:alert] = @comment.errors.full_messages
      render "posts/show"
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    if @comment.delete
      flash[:notice] = t('flash.comments.destroy.success')
      redirect_to post_path(@post)
    else
      flash.now[:alert] = @comment.error.full_messages
      render "post/show"
    end
  end

  def comment_params
    params.require(:comment).permit(:content, :user_id)
  end
end
