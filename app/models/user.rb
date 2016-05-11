class User < ActiveRecord::Base
  has_many :posts
  before_save :hash_password

  def pw_correct?(password)
    self.password == Digest::SHA2.hexdigest(self.username + password)
  end

  private
  def hash_password
    self.password = Digest::SHA2.hexdigest(self.username + self.password)
  end
end
