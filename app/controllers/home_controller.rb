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
    @photos = Photo.all
    response = HTTParty.get("https://api.instagram.com/v1/users/self/media/liked?access_token=#{token}&count=200&max_id=123456")


    3.times do
      @lovely = response.parsed_response["data"]
      @lovely.each do |n|

        welcome = n['images']['standard_resolution']['url']
        if n['location']
          location_name = n['location']['name']
          location_latitude = n['location']['latitude']
          location_longitude = n['location']['longitude']
          Photo.find_or_create_by(url: "#{welcome}", user: session[:user_id], loc_name: "#{location_name}", lat: "#{location_latitude}" , long: "#{location_longitude}")
        else
          Photo.find_or_create_by(url: "#{welcome}", user: session[:user_id])    
        end
      end
      @next = response.parsed_response['pagination']['next_url']
      response = HTTParty.get("#{@next}")
    end

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
