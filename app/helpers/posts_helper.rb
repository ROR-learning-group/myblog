module PostsHelper
  def username(id)
      User.where(id: id).first.username.camelcase
  end

  def email(id)
    User.where(id: id).first.email
  end

  def avatar_path(id)
    User.where(id: id).first.avatar_path
  end

  def allow_change?(user_id)
    if current_user.nil?
      false
    else
      current_user.id == user_id
    end
  end

end
