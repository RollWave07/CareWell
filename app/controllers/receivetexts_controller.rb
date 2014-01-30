class ReceivetextsController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    # let's pretend that we've mapped this action to
    # http://localhost:3000/sms in the routes.rb file

    @comment = params["Body"]
    @assignee = User.where(phone: params["From"].gsub('+1','')).first
    @task = Task.where(assignee_id: @assignee).completed_recently.first
    
    unless @task
        @task = Task.create(user_id: @assignee.id, title: "Text Update", category: "odds & ends", task_date: Time.now + 7.days, duration: 60, groupid:@assignee.group.id)
    end 

    # logger.info "+++task=#{@task.inspect}"

    # user_id =
    #SMSLogger.log_text_message from_number, message_bodyme
    #params.require(:update).permit(:comment, :picture, :task_id, :user_id)
    Update.create(user: @assignee, task: @task, comment:@comment)
  end
end
