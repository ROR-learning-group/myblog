class LikeController < ApplicationController
  before_action :authenticate_user!
  # Post Part
  def post_like
    PostLike.create(status: 0, post_id: params[:post_id], user_id: current_user.id)
    redirect_to params[:ref] || '/'
  end

  def post_dislike
    like = PostLike.where(status: 0, post_id: params[:post_id], user_id: current_user.id).first
    like.destroy
    redirect_to params[:ref] || '/'
  end

  def post_hate
    PostLike.create(status: 1, post_id: params[:post_id], user_id: current_user.id)
    redirect_to params[:ref] || '/'
  end

  def post_dishate
    like = PostLike.where(status: 1, post_id: params[:post_id], user_id: current_user.id).first
    like.destroy
    redirect_to params[:ref] || '/'
  end

  # Comment Part
  def comment_like
    CommentLike.create(status: 0, comment_id: params[:comment_id], user_id: current_user.id)
    redirect_to params[:ref] || '/'
  end

  def comment_dislike
    like = CommentLike.where(status: 0, comment_id: params[:comment_id], user_id: current_user.id).first
    like.destroy
    redirect_to params[:ref] || '/'
  end

  def comment_hate
    CommentLike.create(status: 1, comment_id: params[:comment_id], user_id: current_user.id)
    redirect_to params[:ref] || '/'
  end

  def comment_dishate
    like = CommentLike.where(status: 1, comment_id: params[:comment_id], user_id: current_user.id).first
    like.destroy
    redirect_to params[:ref] || '/'
  end
end
