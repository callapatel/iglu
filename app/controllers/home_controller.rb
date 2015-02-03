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
    redirect_to root_path

  end

  def login
    token = User.find_by(id: session[:user_id]).token
    this_user_atm = session[:user_id]
    #@photos = Photo.all
    if this_user_atm
      @photos = Photo.all
    else
      Photo.api_call_to_db_update(token, this_user_atm)
    end
  end

end
