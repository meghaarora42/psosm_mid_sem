require 'twitter'
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def twitter_data_collection
  	
  	puts params[:keyword_search]
  	
  	@keyword = "police"
  	
  	client = Twitter::Streaming::Client.new do |config|
  		config.consumer_key        = "LQTGcZzXLxxpEQMeqdJ9aZJcu"
  		config.consumer_secret     = "i7auD1jyHCkkdy4y3mpyCzfS6PVqiu98ZDmEF7oO9JJr4C6642"
  		config.access_token        = "180749030-HLsI4GuxY5H5BnI37MgxecWg56ypORZG7g2nyPxU"
  		config.access_token_secret = "AYS3dCBNchYq5mKDfqaOppcAxOQwcUf089CDmZvOANwZT"
	end

	client.filter(track: @keyword do |object|
  		puts object.text if object.is_a?(Twitter::Tweet)
	end

  end



end
