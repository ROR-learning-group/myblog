class PostsController < ApplicationController
  before_action :login?, except: [:index, :show]
  before_action :allow_change?, except: [:index, :show, :new, :create]
  def index
    @posts = Post.all.order(created_at: :desc)
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
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content)
    end

    #Get current user from model
    def current_user
      User.where(username: session[:username]).first
    end

    def login?
      if session[:username].nil?
        redirect_to posts_url, notice: 'Please login to do this.' if @post.nil?
      end
    end

    def allow_change?
      @post = current_user.posts.where(id: params[:id]).first
      redirect_to posts_url, alert: 'You isn\'t able to do this.' if @post.nil?
    end
end
