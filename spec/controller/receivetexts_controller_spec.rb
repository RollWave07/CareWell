require "spec_helper"
require "pry"

describe ReceivetextsController, type: :controller do
  let(:params) { {"Body" => "test body", "From" => "6175158907"} }
  let(:task) {Task.new(title: "test task")}
  let(:current_user) {User.new}

  describe "Receivetexts#index" do
    it "assignes the @task to the correct task when a task is available" do
      # comment.stub(:body).with('a string')
      # expect comment.class.to eq(String)
      # @assignee = 
      # @task = 
      Task.stub_chain(:where, :completed_recently, :first).and_return(task)
      binding.pry

      get :index

      expect(assigns(:task)).to eq(task)




    end

    # it "creates a new task when a task is not available" do
    #   params["Body"] = 



    # end

  end
end

  @task can be nil
    if so, @task will be created using @assignee


    @comment = params["Body"]
    @assignee = User.where(phone: params["From"].gsub('+1','')).first
    @task = Task.where(assignee_id: @assignee).completed_recently.first
    
    unless @task
        @task = Task.create(user_id: @assignee, assignee_id: @assignee, title: "Update")
    end 

    # logger.info "+++task=#{@task.inspect}"

    # user_id =
    #SMSLogger.log_text_message from_number, message_bodyme
    #params.require(:update).permit(:comment, :picture, :task_id, :user_id)
    Update.create(user: @assignee, task:@task, comment:@comment)
  end