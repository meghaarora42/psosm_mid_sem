require 'twitter'
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  @keyword = ''

  def home
  end

  def twitter_data_collection
  	
  	@keyword = params[:keyword_search]
  	puts @keyword
  	
	client = Twitter::REST::Client.new do |config|
  		config.consumer_key        = "LQTGcZzXLxxpEQMeqdJ9aZJcu"
  		config.consumer_secret     = "i7auD1jyHCkkdy4y3mpyCzfS6PVqiu98ZDmEF7oO9JJr4C6642"
  		config.access_token        = "180749030-HLsI4GuxY5H5BnI37MgxecWg56ypORZG7g2nyPxU"
  		config.access_token_secret = "AYS3dCBNchYq5mKDfqaOppcAxOQwcUf089CDmZvOANwZT"
	end

	client.search(@keyword).each do |object|
  		puts object.text 
	end


 #  	client = Twitter::Streaming::Client.new do |config|
 #  		config.consumer_key        = "LQTGcZzXLxxpEQMeqdJ9aZJcu"
 #  		config.consumer_secret     = "i7auD1jyHCkkdy4y3mpyCzfS6PVqiu98ZDmEF7oO9JJr4C6642"
 #  		config.access_token        = "180749030-HLsI4GuxY5H5BnI37MgxecWg56ypORZG7g2nyPxU"
 #  		config.access_token_secret = "AYS3dCBNchYq5mKDfqaOppcAxOQwcUf089CDmZvOANwZT"
	# end

	#   	client = Twitter::Streaming::Client.new do |config|
 #  		config.consumer_key        = "TwJ9IlHYm1Q1ILiS1ZuUhnhkX"
 #  		config.consumer_secret     = "Lxn90WCowwVztys1lCNWzRprRWiPorqhIgYZWzxS9lRhKJOSrh"
 #  		config.access_token        = "180749030-LDenzNjHlDxXipHjSyzaPx6K4q5YFhy7jrnuEN8U"
 #  		config.access_token_secret = "bAv2rrTe1vOFRDduDQMEbWm36Pv3v9leCg1PTB1iX20nr"
	# end

	# args = {}
	# args['keyword'] = @keyword
	# puts args
	# Search.perform_async(args)

	# redirect_to(action:'home')

	# client.filter(track: @keyword) do |object|
 #  		puts object.text if object.is_a?(Twitter::Tweet)
	# end


	redirect_to(:action => 'home')

  end



end

