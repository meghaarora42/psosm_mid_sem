class Tweet
  include Mongoid::Document
  include Mongoid::Timestamps::Created::Short
  include Mongoid::Attributes::Dynamic

end
