require 'rubygems'
require 'twilio-ruby'

# Get your Account Sid and Auth Token from twilio.com/user/account
account_sid = ENV['TWILIO_ACCOUNT_SID']
auth_token = ENV['TWILIO_ACCOUNT_TOKEN']
@client = Twilio::REST::Client.new account_sid, auth_token

message = @client.account.sms.messages.create(
    :to => "6175158907",     # Replace with your phone number
    :from => "8588668901",
    :body => "Jenny please?! I love you hooo!! <3",
    :media_url => "https://demo.twilio.com/owl.png")
puts message.sid