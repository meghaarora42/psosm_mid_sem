# require 'twitter'
# require 'moped'
# Moped::BSON = BSON

# class Search

#   include Sidekiq::Worker
#   include Sidekiq::Status::Worker
#   sidekiq_options :failures => true
#   sidekiq_options unique: true

#   def perform(args)

#     puts "***********WORKER STARTED*********"
#     num_attempts = 50

#     max_id = 0
#     min_id = 0

#     client = Twitter::REST::Client.new do |config|
#       # config.consumer_key       = api_keys.api_key
#       # config.consumer_secret    = api_keys.api_key_secret
#       # config.access_token        = api_keys.access_token
#       # config.access_token_secret = api_keys.access_token_secret
#       config.consumer_key        = "TwJ9IlHYm1Q1ILiS1ZuUhnhkX"
#       config.consumer_secret     = "Lxn90WCowwVztys1lCNWzRprRWiPorqhIgYZWzxS9lRhKJOSrh"
#       config.access_token        = "180749030-LDenzNjHlDxXipHjSyzaPx6K4q5YFhy7jrnuEN8U"
#       config.access_token_secret = "bAv2rrTe1vOFRDduDQMEbWm36Pv3v9leCg1PTB1iX20nr"
#     end

#     while num_attempts > 0

#       num_attempts = num_attempts - 1

#       value = args['keyword']
#       client.search(value).take(100).tap do |head, *body, tail|
#         max_id = head.id
#         tweet_hash = head.to_h
#         begin
#           tweet = Tweet.create(tweet_hash)
#           tweet.save
#         rescue Moped::Errors::OperationFailure => e
#           puts "Error #{$ERROR_INFO}, #{e}"
#           raise e
#         end
#         min_id = tail.id
#         tweet_hash = tail.to_h
#         begin
#           weet = Tweet.create(tweet_hash)
#           tweet.save
#         rescue Moped::Errors::OperationFailure => e
#           puts "Error #{$ERROR_INFO}, #{e}"
#           raise e
#         end
#         body.each do |tweet|
#           tweet_hash = tweet.to_h
#           begin
#             tweet = Tweet.create(tweet_hash)
#             tweet.save
#           rescue Moped::Errors::OperationFailure => e
#             puts "Error #{$ERROR_INFO}, #{e}"
#             raise e
#           end
#         end
#       end


#     # rescue Twitter::Error::NoMethodError => e
#     #   result = { error: true, code: 101, description: 'NoMethodError:NoPostsForQuery', max_id: max_id, min_id: min_id }

#     # rescue Twitter::Error::TooManyRequests => e
#     #   sleep e.rate_limit.reset_in
#     end

#   end
# end
