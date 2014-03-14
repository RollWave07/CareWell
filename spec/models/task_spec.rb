require 'spec_helper'

describe Task do 
  let(:users) do
    User.create!([
      {first_name: "Tinker",last_name: "Bell", email: "tinker@bell.com", password:"password", phone: 6175158907, group_id: 1, admin: false },
      {first_name: "Tiger",last_name: "Lily", email: "tiger@lily.com", password:"password", phone: 6175158907, group_id: 1, admin: false }])
  end
  let(:tasks) do
    Task.create!([
      {title: "Task 1", groupid: 1, category: "getting places", duration: 60, task_date: Time.now+1.day, assignee_id: nil , user_id: User.first.id},
      {title: "Task 2", groupid: 1, category: "getting places", duration: 60, task_date: Time.now+1.day, assignee_id: User.first.id , user_id: User.first.id},
      {title: "Task 3", groupid: 1, category: "getting places", duration: 60, task_date: Time.now+1.day, assignee_id: User.find(User.first.id+1).id , user_id: User.first.id},
      {title: "Task 4", groupid: 1, category: "getting places", duration: 60, task_date: Time.now+1.day, assignee_id: User.last.id , user_id: User.first.id}])
  end
  # subject do
  #   Task.create()

  # end  
  describe "#upcoming_tasks(group)" do
    it 'returns four tasks' do
      users
      tasks
      expect(Task.upcoming_tasks(1).count).to eq 4
    end
    # its(:unassigned) {should = 3}
  end
  describe "#unassigned(tasks)" do
    
    it 'returns 1 ' do
      users
      tasks
      expect(Task.unassigned(Task.all).count).to eq 1
    end
  end
  
  describe 'validations' do
    describe 'presence' do
      context 'when given an :title' do
        it 'creates a new record' do
          new_task = Task.create( title: "Made a new task")
          expect(new_task).to be_valid
          expect(Task.count).to eq 1
        end
      end
      context 'when given nothing' do
        it 'fails to create a record' do
          new_task = Task.create
          expect(new_task).to_not be_valid
          expect(Task.count).to eq 0
          expect(new_task.errors.full_messages).to include("Title can't be blank")
        end
      end
    end
  end

end