require "spec_helper"

describe RecievetextsController do
  describe "Post#index" do
    it "assignes the @task to the correct task when a task is available" do
      comment.stub(:body).with('a string')
      expect comment.class.to eq(String)
      # @assignee = 
      # @task = 


    end

    # it "creates a new task when a task is not available" do
    #   params["Body"] = 



    # end

  end
end


  #   @comment = params["Body"]
  #   @assignee = User.where(phone: params["From"].gsub('+1','')).first
  #   @task = Task.where(assignee_id: @assignee).completed_recently.first
    
  #   unless @task
  #       @task = Task.create(user_id: @assignee, assignee_id: @assignee, title: "Update")
  #   end 

  #   # logger.info "+++task=#{@task.inspect}"

  #   # user_id =
  #   #SMSLogger.log_text_message from_number, message_bodyme
  #   #params.require(:update).permit(:comment, :picture, :task_id, :user_id)
  #   Update.create(user: @assignee, task:@task, comment:@comment)
  # end