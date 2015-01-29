class HomeController < ApplicationController
  def index
    #why you should sign up for this service page and partial for when you are logged in.
  end

  def create
    auth_hash = request.env['omniauth.auth']
    @user = User.where(uid: auth_hash['uid']).first
    if @user == nil
      User.createuser_from_omniauth(auth_hash)
      session[:user_id] = @user.id
    else
      session[:user_id] = @user.id
    end
    raise
    redirect_to root_path

  end

  def login

  end

end
