class HomeController < ApplicationController


  def index
    #why you should sign up for this service page and partial for when you are logged in.
  end

  def create
    auth_hash = request.env['omniauth.auth']
    @user = User.where(uid: auth_hash['uid']).first
    if @user == nil
      @user = User.createuser_from_omniauth(auth_hash)
      session[:user_id] = @user.id
      token = current_user.token
      Photo.api_call_to_db_update(token, current_user.id)
    else
      session[:user_id] = @user.id
    end
    redirect_to root_path
  end

  def login
    token = current_user.token #User.find_by(id: session[:user_id])
    this_user_atm = current_user.id #session[:user_id]
    if require_login
      if this_user_atm.present?
        @photos = Photo.paginate(:page => params[:page], :per_page => 30)
        #Photo.api_call_to_db_update(token, this_user_atm)
        #Photo.yelp
        #Photo.google
      else
        Photo.api_call_to_db_update(token, this_user_atm)
        Photo.google
        Photo.yelp
      #this_user_atm.present? ? @photos = Photo.paginate(:page => params[:page], :per_page => 30) : Photo.api_call_to_db_update(token, this_user_atm)
      end
    end

  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = true
    redirect_to login_path
  end

end
