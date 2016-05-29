class AddCommentsCountToPost < ActiveRecord::Migration
  def change
    add_column :posts, :comments_count, :integer, :default => 0

    #Reset comments_count
    Post.find_each do |post|
      Post.reset_counters post.id, :comments
    end
  end
end
