class UsersController < ApplicationController
  def login
    user = User.where(username: params[:username]).first
    if(user && user.pw_correct?(params[:password]))
      session[:user_id] = user.id
      session[:username] = user.username
    else
      flash[:notice] = 'Username doesn\'t exist or Password is wrong.'
    end
    redirect_to posts_path
  end

  def logout
    session[:user_id] = session[:username] = nil
    redirect_to posts_path
  end

end
