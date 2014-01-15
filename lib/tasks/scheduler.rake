desc "This task will send a message"
task :text => :environment do
  time_now = Time.now
  account_sid = ENV['TWILIO_ACCOUNT_SID']
    auth_token = ENV['TWILIO_ACCOUNT_TOKEN']
    @client = Twilio::REST::Client.new account_sid, auth_token
    
    message = @client.account.sms.messages.create(
      :to => "6175158907",  
      :from => "8588668901",
      :body => "Jenny please?! I love you hooo!! <3"
    )
  # puts "done."
end

# task :send_reminders => :environment do
#   User.send_reminders
# end