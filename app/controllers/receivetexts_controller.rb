class ReceivetextsController < ApplicationController
  def index
    # let's pretend that we've mapped this action to 
    # http://localhost:3000/sms in the routes.rb file
    
    @comment = params["Body"]
    @user = User.where(phone: params["From"].gsub('+1','')).first
    @task = @user.tasks.completed_recently.first

    logger.info "+++task=#{@task.inspect}"

    # user_id = 
    #SMSLogger.log_text_message from_number, message_bodyme
    #params.require(:update).permit(:comment, :picture, :task_id, :user_id)
    Update.create(user: @user, task:@task, comment:@comment) 
  end
end
