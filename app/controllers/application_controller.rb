require 'twitter'
class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  @keyword = ''

  helper_method :analytic

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
      # config.consumer_key        = "TwJ9IlHYm1Q1ILiS1ZuUhnhkX"
      # config.consumer_secret     = "Lxn90WCowwVztys1lCNWzRprRWiPorqhIgYZWzxS9lRhKJOSrh"
      # config.access_token        = "180749030-LDenzNjHlDxXipHjSyzaPx6K4q5YFhy7jrnuEN8U"
      # config.access_token_secret = "bAv2rrTe1vOFRDduDQMEbWm36Pv3v9leCg1PTB1iX20nr"
	end

	client.search(@keyword).each do |object|
  		puts object.text 
  		tweet_hash = object.to_h
  		tweet = Tweet.create(tweet_hash)
		tweet.save
	end

	# tweets = Tweet.all
	# tweets.each do |tweet|
	# 	puts tweet.text
	# end
	redirect_to(:action => 'home')
  end

  def analytic
  	tweets = Tweet.all
  	text = ''
  	tweets.each do |tweet|
  		text += tweet.text
  	end
  	response = count_words(text)
  	puts response
  end

  
  def count_words(string)
  	words = string.split(' ')
  	frequency = Hash.new(0)
  	words.each { |word| frequency[word.downcase] += 1 }
  	return frequency
  end

end

