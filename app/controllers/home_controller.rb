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
    response = HTTParty.get("https://api.instagram.com/v1/users/self/media/liked?access_token=#{token}")
    @lovely = response.parsed_response["data"]
  end


  private

    def find_provider
      @provider = Provider.find_by_name_and_user_id("instagram", session[:user_id])
    end

    def create_instagram_client
      find_provider

      Instagram.configure do |config|
        config.client_id = ENV["INSTAGRAM_CLIENT_ID"]
        config.client_secret = ENV["INSTAGRAM_CLIENT_SECRET"]
        config.access_token =  @provider.token
      end
    end

end
