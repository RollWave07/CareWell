require "spec_helper"
require "pry"

describe ReceivetextsController, type: :controller do
  let(:user) do
    User.create(first_name: "Captain",last_name: "Hook", email: "captain@hook.com", password:"password", phone: 6175158907, group_id: 1, admin: true )
    
  end
  let(:task) do
    Task.create(title: "Sample Task", groupid: 1, category: "getting places", duration: 60, task_date: Time.now, assignee_id: 1 , user_id: 1)
  end

  describe "GET 'index'" do
    it "returns http success" do
      user
      task
      get 'index', "Body" => "test body", "From" => "6175158907"
      response.should be_success
    end
    it "creates an update" do
      user
      task
      get 'index', "Body" => "test body", "From" => "6175158907"
      expect(Update.count).to eq(1)
    end
    # it "assignes user one to the most recent task" do
      
    # end
    # it "creates a new task when task not found" do
      
    # end
  end

  
end

 