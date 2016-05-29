class CommentLike < ActiveRecord::Base
  belongs_to :comment
  belongs_to :user

  before_save :prevent_repeated_click
  after_save :add_counter
  before_destroy :sub_counter

  private
  def add_counter
    if self.status == 0
      count = self.comment.likes_count
      self.comment.update(likes_count: count+1)
    else
      count = self.comment.hates_count
      self.comment.update(hates_count: count+1)
    end
  end

  def sub_counter
    if self.status == 0
      count = self.comment.likes_count
      self.comment.update(likes_count: count-1)
    else
      count = self.comment.hates_count
      self.comment.update(hates_count: count-1)
    end
  end

  def prevent_repeated_click
    CommentLike.where(comment_id: self.comment_id, user_id: self.user_id).each do |record|
      record.destroy
    end
  end
end
