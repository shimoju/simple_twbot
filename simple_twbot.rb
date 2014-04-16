require 'twitter'
require 'dotenv'
require 'yaml'
require 'redis'

# .envから環境変数をロード
Dotenv.load

# ツイートリストを読み込み
tweets = YAML.load_file 'tweets.yml'

# Redisをセットアップ
if ENV['REDISTOGO_URL']
    redis = Redis.new(url: ENV['REDISTOGO_URL'])
else
    redis = Redis.new
end

# 前回の履歴を取得
last_tweet = redis.get 'last_tweet'

# Twitterにログイン
client = Twitter::REST::Client.new do |config|
  config.consumer_key = ENV['API_KEY']
  config.consumer_secret = ENV['API_SECRET']
  config.access_token  = ENV['ACCESS_TOKEN']
  config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
end

# ツイートして履歴をRedisにセット
if last_tweet && tweets[last_tweet.to_i + 1]
  client.update(tweets[last_tweet.to_i + 1])
  redis.incr 'last_tweet'
else
  client.update(tweets.first)
  redis.set 'last_tweet', 0
end

puts "Tweet."
