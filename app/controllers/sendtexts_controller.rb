class SendtextsController < ApplicationController
  def index
  end

  def send_text_message
    task = Task.where(id: params[:task_id]).first
    assignee = task.assignee

    account_sid = ENV['TWILIO_ACCOUNT_SID']
    auth_token = ENV['TWILIO_ACCOUNT_TOKEN']
    @client = Twilio::REST::Client.new account_sid, auth_token

    @client.account.sms.messages.create(
      :to => "#{assignee.phone}",
      :from => "8588668901",
      :body => "Hi #{assignee.first_name} How did the task, #{task.title}, go?"
    )
  end

end
