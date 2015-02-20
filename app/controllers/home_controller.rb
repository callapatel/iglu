class HomeController < ApplicationController


  def index
    #why you should sign up for this service page and partial for when you are logged in.
  end

  def create
    auth_hash = request.env['omniauth.auth']
    @user = User.find_by(uid: auth_hash['uid'])
    if @user
      session[:user_id] = User.find_by(uid: auth_hash['uid']).id
    else
      @user = User.createuser_from_omniauth(auth_hash)
      session[:user_id] = @user.id
      current_user = User.find(session[:user_id])
      token = auth_hash["credentials"]['token']
      Photo.api_call_to_db_update(token, current_user.id)
      Photo.google
      Photo.yelp
    end
    redirect_to root_path
  end

  def login
    token = current_user.token #User.find_by(id: session[:user_id])
    this_user_atm = current_user.id #session[:user_id]
    if require_login
      if this_user_atm.present?
        #@photos = Photo.all
        @photos = Photo.paginate(:page => params[:page], :per_page => 30)
        #Photo.api_call_to_db_update(token, this_user_atm)
        #Photo.yelp
        #Photo.google(this_user_atm)
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

  def delete
    Photo.find(params[:pictured]).destroy
    redirect_to root_path
  end

end
