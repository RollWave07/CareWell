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
task :send_reminders => :environment do


  time_from = Time.now
  time_to = Time.now+1.day

  tasks = Task.where(task_date:(time_from..time_to))

  tasks.each do |task|
    
    
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    auth_token = ENV['TWILIO_ACCOUNT_TOKEN']
    @client = Twilio::REST::Client.new account_sid, auth_token
    
    message = @client.account.sms.messages.create(
      :to => "#{task.assignee.phone}",  
      :from => "8588668901",
      :body => "Hi #{task.assignee.first_name}, This is a reminder that your task: #{task.name} is tomorrow at #{task.task_date}."
    )
  end  
  # puts "done."
end

task :task_update => :environment do

  time_from = 1.day.ago
  time_to = Time.now

  tasks = Task.where(task_date:(time_from..time_to))

  tasks.each do |task|
    
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    auth_token = ENV['TWILIO_ACCOUNT_TOKEN']
    @client = Twilio::REST::Client.new account_sid, auth_token
    
    message = @client.account.sms.messages.create(
      :to => "#{task.assignee.phone}",  
      :from => "8588668901",
      :body => "Hi #{task.assignee.first_name}, How did the task: #{task.name} go? Text back an update and it will be added onto the task page."
    )
  end  
end