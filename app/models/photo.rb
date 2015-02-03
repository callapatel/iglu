class Photo < ActiveRecord::Base
  has_many :album_photos
  has_many :albums, through: :album_photos

  def find_token
  end

  def self.api_call_to_db_update(token, this_user_atm)
    response = HTTParty.get("https://api.instagram.com/v1/users/self/media/liked?access_token=#{token}&count=200&max_id=123456")
    3.times do
      @lovely = response.parsed_response["data"]
      @lovely.each do |n|
        welcome = n['images']['standard_resolution']['url']
        if n['location'] && n['caption']
          location_name = n['location']['name']
          location_latitude = n['location']['latitude']
          location_longitude = n['location']['longitude']
          #caption = n['caption']['text']
          ig_user = n['caption']['from']['username']
          Photo.find_or_create_by(url: "#{welcome}", user: this_user_atm, loc_name: "#{location_name}", lat: "#{location_latitude}", long: "#{location_longitude}")#, caption: "#{caption}", ig_user: "#{ig_user}")
        else
          Photo.find_or_create_by(url: "#{welcome}", user: this_user_atm, ig_user: "#{ig_user}" )
        end
      end
      @next = response.parsed_response['pagination']['next_url']
      response = HTTParty.get("#{@next}")
    end
  end

 def self.api_calling











   token = @current_user.token
   this_user_atm = @current_user.id 
   response = HTTParty.get("https://api.instagram.com/v1/users/self/media/liked?access_token=#{token}&count=200&max_id=123456")
   3.times do
     @lovely = response.parsed_response["data"]
     @lovely.each do |n|
       welcome = n['images']['standard_resolution']['url']
       if n['location'] && n['caption']
         location_name = n['location']['name']
         location_latitude = n['location']['latitude']
         location_longitude = n['location']['longitude']
         #caption = n['caption']['text']
         ig_user = n['caption']['from']['username']
         Photo.find_or_create_by(url: "#{welcome}", user: this_user_atm, loc_name: "#{location_name}", lat: "#{location_latitude}", long: "#{location_longitude}")#, caption: "#{caption}", ig_user: "#{ig_user}")
       else
         Photo.find_or_create_by(url: "#{welcome}", user: this_user_atm, ig_user: "#{ig_user}" )
       end
     end
     @next = response.parsed_response['pagination']['next_url']
     response = HTTParty.get("#{@next}")
   end

 end


end
