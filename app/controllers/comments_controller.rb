class CommentsController < ApplicationController
  before_action :allow_delete?, only: [:destroy]

  def create
    @comment = Comment.new(comment_params)
    @comment.save
    redirect_to post_path(id: params[:post_id]), notice: 'Comment was successfully created.'
  end

  def destroy
    Comment.where(id: params[:id], post_id: params[:post_id]).first.destroy
    redirect_to post_path(id: params[:post_id]), notice: 'Comment was successfully destroyed.'
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      cp = params.require(:comment).permit(:name, :email, :content)
      cp[:post_id] = params[:post_id]
      cp
    end
    def allow_delete?
      post = current_user.posts.where(id: params[:post_id]).first
      comment = post.comments.where(id: params[:id]).first
      if comment.nil?
        redirect_to post_path(id: params[:post_id]), alert: 'You are not able to do this.'
      end

    end
end
