class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @posts = Post.order(created_at: :desc).page params[:page]
  end

  def show
    @post = Post.where(id: params[:id]).first
    @comments = @post.comments.all.order(created_at: :desc)
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
    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content)
    end

    def allow_change?
      @post = current_user.posts.where(id: params[:id]).first
      redirect_to posts_url, alert: 'You are not able to do this.' if @post.nil?
    end
end
