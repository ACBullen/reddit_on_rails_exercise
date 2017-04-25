class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.author = current_user

    if @comment.save
      redirect_to post_url(@comment.post_id)
    else
      flash[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  def new
    @comment = Comment.new
    @comment.post = Post.find(params[:post_id])
    render :new
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content, :post_id, :parent_comment_id)
  end

  def upvote
    @comment = Comment.find(params[:id])
    vote = Vote.new(value: 1)
    vote.votable = @comment
    vote.save
    redirect_to comment_url(@comment)
  end

  def downvote
    @comment = Comment.find(params[:id])
    vote = Vote.new(value: -1)
    vote.votable = @comment
    vote.save
    redirect_to comment_url(@comment)
  end
end
