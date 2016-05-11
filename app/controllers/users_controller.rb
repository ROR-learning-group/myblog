class UsersController < ApplicationController
  def login
    user = User.where(username: params[:username]).first
    if(user && user.pw_correct?(params[:password]))
      session[:username] = user.username
    else
      flash[:notice] = '使用者不存在/密碼錯誤。'
    end
    return redirect_to posts_path
  end
  def logout
    session[:username] = nil
    return redirect_to posts_path
  end
end
