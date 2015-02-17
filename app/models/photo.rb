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
        if n['location']
          location_name = n['location']['name']
          location_latitude = n['location']['latitude']
          location_longitude = n['location']['longitude']
          n['caption'].present? ? caption = n['caption']['text'] : "nil"
          n['caption'].present? ? ig_user = n['caption']['from']['username'] : nil
          Photo.find_or_create_by(url: "#{welcome}", user: this_user_atm, loc_name: "#{location_name}", lat: "#{location_latitude}", long: "#{location_longitude}", caption: "#{caption}", ig_user: "#{ig_user}")
        else
          n['caption'].present? ? caption = n['caption']['text'] : "nil"
          n['caption'].present? ? ig_user = n['caption']['from']['username'] : nil
          Photo.find_or_create_by(url: "#{welcome}", user: this_user_atm, ig_user: "#{ig_user}", caption: "#{caption}" )
        end
      end
      @next = response.parsed_response['pagination']['next_url']
      response = HTTParty.get("#{@next}")
    end
  end

  def self.api_calling
    puts "running this method"
    User.all.each do |user|
      token = user.token
      this_user_atm = user.id
      response = HTTParty.get("https://api.instagram.com/v1/users/self/media/liked?access_token=#{token}&count=200&max_id=123456")
      3.times do
        @lovely = response.parsed_response["data"]
        @lovely.each do |n|
          welcome = n['images']['standard_resolution']['url']
          if n['location']
            location_name = n['location']['name']
            location_latitude = n['location']['latitude']
            location_longitude = n['location']['longitude']
            n['caption'].present? ? caption = n['caption']['text'] : "nil"
            n['caption'].present? ? ig_user = n['caption']['from']['username'] : nil
            Photo.find_or_create_by(url: "#{welcome}", user: this_user_atm, loc_name: "#{location_name}", lat: "#{location_latitude}", long: "#{location_longitude}", caption: "#{caption}", ig_user: "#{ig_user}")
          else
            n['caption'].present? ? caption = n['caption']['text'] : "nil"
            n['caption'].present? ? ig_user = n['caption']['from']['username'] : nil
            Photo.find_or_create_by(url: "#{welcome}", user: this_user_atm, ig_user: "#{ig_user}", caption: "#{caption}" )
          end
        end
        @next = response.parsed_response['pagination']['next_url']
        response = HTTParty.get("#{@next}")
      end
    end
  end



  def self.google
    puts "googleit"
    Photo.all.each do |n|
      @client = GooglePlaces::Client.new(ENV['GOOGLE_KEY'])
      if n.lat == "" or n.lat == nil
        @hope1 = ""
        Photo.find(n.id).update(google_name: "#{@hope1}")
      else
        @hope1 = @client.spots(n.lat, n.long)[0].name
        Photo.find(n.id).update(google_name: "#{@hope1}")
      end
    end
  end

  def self.yelp


    Photo.all.each do |n|
      coordinates = { latitude: n.lat, longitude: n.long}
      @client = GooglePlaces::Client.new(ENV['GOOGLE_KEY'])
      filter = {limit: 1, radius_filter: 1609.34, }
      @result = Yelp.client.search_by_coordinates(coordinates, filter) rescue []
      if @result == []
        n.lat != 'nil' ? @hope= '' : @hope = @client.spots(n.lat, n.long)[0].name
        rawr = Photo.find(n.id).update(google_name: "#{@hope}")
        Photo.find(n.id).google_name.present? ? nil : rawr
      elsif @result.businesses == []
        n.loc_name == nil ? @hope = @client.spots(n.lat, n.long)[0].name : @hope = @client.spots(n.lat, n.long, :name => n.loc_name)
        rawr = Photo.find(n.id).update(google_name: "#{@hope}")
        Photo.find(n.id).google_name.present? ? nil : rawr
      else
        @yelpurl = @result.businesses[0].url
        rawr = Photo.find(n.id).update(yelp_url: "#{@yelpurl}")
        Photo.find(n.id).google_name.present? ? nil : rawr
      end
    end
  end






    # It returns the articles whose titles contain one or more words that form the query
    def self.search(query)
      # where(:title, query) -> This would return an exact match of the query
      where("loc_name like ?", "%#{query}%")
    end


end
