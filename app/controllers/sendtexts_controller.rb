class SendtextsController < ApplicationController
  def index
  end

  def send_text_message
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    auth_token = ENV['TWILIO_ACCOUNT_TOKEN']
    @client = Twilio::REST::Client.new account_sid, auth_token
    
    @client.account.sms.messages.create(
      :to => "6175158907",  
      :from => "8588668901",
      :body => "Jenny please?! I love you hooo!! <3"
    )
  end
  
end
