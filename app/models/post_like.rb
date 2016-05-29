class PostLike < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  before_save :prevent_repeated_click
  after_save :add_counter
  before_destroy :sub_counter

  private
  def add_counter
    if self.status == 0
      count = self.post.likes_count
      self.post.update(likes_count: count+1)
    else
      count = self.post.hates_count
      self.post.update(hates_count: count+1)
    end
  end

  def sub_counter
    if self.status == 0
      count = self.post.likes_count
      self.post.update(likes_count: count-1)
    else
      count = self.post.hates_count
      self.post.update(hates_count: count-1)
    end
  end

  def prevent_repeated_click
    PostLike.where(post_id: self.post_id, user_id: self.user_id).each do |record|
      record.destroy
    end
  end
end
