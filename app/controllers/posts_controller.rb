class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @posts = Post.includes(:user).order(created_at: :desc).page params[:page]
    post_likes = current_user.post_likes.where(id: @posts.map(&:id)) rescue nil
    @user_likes = post_likes.map{|l| l.post_id if l.status == 0} rescue []
    @user_hates = post_likes.map{|l| l.post_id if l.status == 1} rescue []
  end

  def show
    @post = Post.where(id: params[:id]).includes(:user).first
    @comments = @post.comments.order(created_at: :desc).page params[:page]

    # Query user like/hate list by one query and store them to array
    post_like = current_user.post_likes.where(post_id: params[:id]).first rescue nil
    @user_post_like = (post_like.status == 0) rescue false
    @user_post_hate = (post_like.status == 1) rescue false
    comment_likes = current_user.comment_likes.where(comment_id: @post.comments.map(&:id)) rescue nil
    @user_comment_likes = comment_likes.map{|c| c.comment_id if c.status == 0} rescue []
    @user_comment_hates = comment_likes.map{|c| c.comment_id if c.status == 1} rescue []

    @new_comment = Comment.new(post_id: params[:id])
  end

  def new
    @post = current_user.posts.new
  end

  def edit
    @post = current_user.posts.where(id: params[:id]).first
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def update
      if @post.update(post_params)
        redirect_to @post, notice: 'Post was successfully updated.'
      else
        render :edit
      end
  end

  def destroy
    @post = current_user.posts.where(id: params[:id]).first
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  private
    def post_params
      params.require(:post).permit(:title, :content)
    end

    def allow_change?
      @post = current_user.posts.where(id: params[:id]).first
      redirect_to posts_url, alert: 'You are not able to do this.' if @post.nil?
    end
end
