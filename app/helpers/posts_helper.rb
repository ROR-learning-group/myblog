module PostsHelper
  def username(id)
    User.where(id: id).first.username.camelcase
  end

  def avatar_path(id)
    User.where(id: id).first.avatar_path
  end

  def allow_change?(user_id)
    if session[:user_id].nil?
      false
    else
      user_id == session[:user_id]
    end
  end

end
