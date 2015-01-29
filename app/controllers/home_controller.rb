class HomeController < ApplicationController
  def index
    #why you should sign up for this service page and partial for when you are logged in.
  end

  def create
    auth_hash = request.env['omniauth.auth']
    User.create(
      name: auth_hash['info']['name'],
      uid: auth_hash['uid'],
      token: auth_hash["credentials"]['token'],
    )
    redirect_to root_path
  end

  def login

  end
  
end
