class Comment < ActiveRecord::Base
  belongs_to :post, :counter_cache => true
  has_many :comment_like, dependent: :destroy
  validates :name, presence: true
end
