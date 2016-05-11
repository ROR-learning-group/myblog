class User < ActiveRecord::Base
  has_many :posts

  def pw_correct?(password)
    self.password == Digest::SHA2.hexdigest(self.username + password)
  end
end
