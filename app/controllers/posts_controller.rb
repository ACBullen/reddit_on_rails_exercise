class PostsController < ApplicationController
  before_filter :author?, only: [:edit, :update]
  def new
    @post = Post.new
    render :new
  end

  def author?
    @post = Post.friendly.find(params[:id])
    redirect_to sub_url(@post.sub_id) unless @post.author == current_user
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user

    unless @post.save
      flash[:errors] = @post.errors.full_messages
    end
    redirect_to subs_url
  end

  def edit
    @post = Post.friendly.find(params[:id])
    render :edit
  end

  def update
    @post = Post.friendly. find(params[:id])
    unless @post.update_attributes(post_params)
      flash[:errors] = @post.errors.full_messages
    end
    redirect_to subs_url
  end

  def show
    @post = Post.friendly.find(params[:id])
    @com_hash = @post.comments_by_parent_id
    render :show
  end

  def upvote
    @post = Post.friendly.find(params[:id])
    vote = Vote.new(value: 1)
    vote.votable = @post
    vote.save
    redirect_to @post
  end

  def downvote
    @post = Post.friendly.find(params[:id])
    vote = Vote.new(value: -1)
    vote.votable = @post
    vote.save
    redirect_to @post
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end
end
