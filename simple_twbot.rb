require 'twitter'
require 'dotenv'
require 'redis'

# .envから環境変数をロード
Dotenv.load

# Redisをセットアップ
redis = Redis.new

# 前回の履歴を取得
last_tweet = redis.get 'last_tweet'

# Twitterにログイン
client = Twitter::REST::Client.new do |config|
  config.consumer_key = ENV['API_KEY']
  config.consumer_secret = ENV['API_SECRET']
  config.access_token  = ENV['ACCESS_TOKEN']
  config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
end
