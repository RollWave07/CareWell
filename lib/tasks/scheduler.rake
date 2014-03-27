desc "This task will send a message"

# task :confirm_task => :environment do

#   upcoming_tasks = Task.where(task_date:(Time.now+1.day..Time.now+8.days))
#   unique_user = upcoming_tasks.select(:assignee_id).distinct
#   count = 0
#   unique_user.each do |u|
#     if u.assignee_id != nil
#       if u.assignee.phone.empty?
#         puts "#{u.assignee.first_name} will receive the mailer."
#       else
#         puts "#{u.assignee.first_name} will receive text."
#       end
#       count += 1
#     end
#   end
#   puts count
# end

desc "This sends a message to the owner if no one is assigned within 2 days."

task :not_covered_decision => :environment do
  time_from = Time.now
  time_to = Time.now+2.days
  tasks = Task.where(task_date:(time_from..time_to), :group_id =>! nil)

  tasks.each do |task|
    if task.user.phone.empty?
      MailerInvitation.not_covered_upcoming_task(task).deliver
    else
      account_sid = ENV['TWILIO_ACCOUNT_SID']
      auth_token = ENV['TWILIO_ACCOUNT_TOKEN']
      @client = Twilio::REST::Client.new account_sid, auth_token
      message = @client.account.sms.messages.create(
        :to => "#{task.user.phone}",
        :from => "8588668901",
        :body => "Heads Up! From CareWell: Hi #{task.user.first_name}, the task: #{task.title} is coming up but isn't covered. Modify it at carewell.herokuapp.com."
        )
    end
  end
end

task :send_reminders => :environment do

  time_from = Time.now+1.day
  time_to = Time.now+2.days

  tasks = Task.where(task_date:(time_from..time_to))

  tasks.each do |task|
    if task.assignee.phone.empty?
      MailerInvitation.task_reminder(task).deliver
    else
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    auth_token = ENV['TWILIO_ACCOUNT_TOKEN']
    @client = Twilio::REST::Client.new account_sid, auth_token
    message = @client.account.sms.messages.create(
      :to => "#{task.assignee.phone}",
      :from => "8588668901",
      :body => "From CareWell: Hi #{task.assignee.first_name}, your task: #{task.title} is coming up! Call or email #{task.user.first_name} with questions."
    )
    end
  end
end

task :task_update => :environment do

  time_from = 1.day.ago
  time_to = Time.now

  tasks = Task.where(task_date:(time_from..time_to))

  account_sid = ENV['TWILIO_ACCOUNT_SID']
  auth_token = ENV['TWILIO_ACCOUNT_TOKEN']
  @client = Twilio::REST::Client.new account_sid, auth_token

  tasks.each do |task|
    message = @client.account.sms.messages.create(
      :to => "#{task.assignee.phone}",
      :from => "8588668901",
      :body => "Hi #{task.assignee.first_name}, How did the task: #{task.title} go? Text back an update and it will be added onto the task page."
    )
  end
end

