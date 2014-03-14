require "spec_helper"
require "pry"

describe ReceivetextsController, type: :controller do
  let(:user) do
    User.create!([{first_name: "Captain",last_name: "Hook", email: "captain@hook.com", password:"password", phone: 6175158907, group_id: 1, admin: true},
      {first_name: "Tiger",last_name: "Lily", email: "tiger@lily.com", password:"password", phone: 6175158907, group_id: 1, admin: false }
     ])
    
  end
  let(:task) do
    Task.create!([
      {title: "Sample Task 2", groupid: 1, category: "getting places", duration: 60, task_date: Time.now+1.day, assignee_id: User.first.id , user_id: User.first.id},
      {title: "Sample Task 3", groupid: 1, category: "getting places", duration: 60, task_date: Time.now-2.day, assignee_id: User.first.id , user_id: User.first.id},
      {title: "Sample Task 4", groupid: 1, category: "getting places", duration: 30, task_date: Time.now-1.hour, assignee_id: nil , user_id: User.first.id}])

  end

  describe "recieves a text" do
    it "returns http success" do
      user
      task
      get 'index', "Body" => "test body", "From" => "6175158907"
      response.should be_success
    end
    
    context 'finds a recently completed task' do
      it "creates an update on an existing task" do
        user
        task
        Task.create(title: "Sample Task 1", groupid: 1, category: "getting places", duration: 30, task_date: Time.now-1.hour, assignee_id: User.first.id , user_id: User.first.id)
        get 'index', "Body" => "test body", "From" => "6175158907"
        expect(Update.count).to eq(1)
        assert_equal Update.first.task.title, "Sample Task 1"
      end
      it 'assignes it to the correct user' do
        user
        task
        Task.create(title: "Sample Task 5", groupid: 1, category: "getting places", duration: 30, task_date: Time.now-1.hour, assignee_id: User.last.id , user_id: User.last.id)
        Task.create(title: "Sample Task 1", groupid: 1, category: "getting places", duration: 30, task_date: Time.now-2.hour, assignee_id: User.first.id , user_id: User.last.id)
        
        get 'index', "Body" => "test body", "From" => "6175158907"
        expect(Update.count).to eq(1)
        assert_equal Update.first.task.title, "Sample Task 1"
      end
    end

    context 'does not find a recent completed task' do
      it "creates an update on a new task" do
        user
        task
        get 'index', "Body" => "test body", "From" => "6175158907"
        expect(Update.count).to eq(1)
        assert_equal Update.first.id, Task.last.updates.take.id
        assert_equal Task.last.title, "Text Update"
      end
    end
  end

  
end

 