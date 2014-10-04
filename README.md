# SimpleTwbot

Simple Twitter Bot

## Setup

```
git clone https://github.com/shimoju/simple_twbot your_bot_name
cp sample.env .env
```

Edit `tweets.yml`

```
heroku create your-bot-name
heroku addons:add scheduler
heroku addons:add redistogo
heroku config:set API_KEY=your_key API_SECRET=your_secret ACCESS_TOKEN=your_token ACCESS_TOKEN_SECRET=your_secret
git push heroku master
```
