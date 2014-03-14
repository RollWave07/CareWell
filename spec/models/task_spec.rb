require 'spec_helper'

describe Task do 
  let(:users) do
    User.create!([
      {first_name: "Tinker",last_name: "Bell", email: "tinker@bell.com", password:"password", phone: 6175158907, group_id: 1, admin: false },
      {first_name: "Tiger",last_name: "Lily", email: "tiger@lily.com", password:"password", phone: 6175158907, group_id: 1, admin: false },
      {first_name: "Holy",last_name: "Spearit", email: "holy@spearit.com", password:"password", phone: 6175158907, group_id: 2, admin: true }])
  end
  let(:tasks) do
    Task.create!([
      {title: "Task 1", groupid: 1, category: "getting places", duration: 30, task_date: Time.now+1.day, assignee_id: nil , user_id: User.first.id},
      {title: "Task 2", groupid: 1, category: "getting places", duration: 60, task_date: Time.now+1.day, assignee_id: User.first.id , user_id: User.first.id},
      {title: "Task 3", groupid: 1, category: "meals", duration: 90, task_date: Time.now+1.day, assignee_id: User.find(User.first.id+1).id , user_id: User.first.id},
      {title: "Task 4", groupid: 1, category: "odds & ends", duration: 15, task_date: Time.now+1.day, assignee_id: User.find(User.first.id+1).id , user_id: User.first.id},
      {title: "Task 5", groupid: 2, category: "getting places", duration: 60, task_date: Time.now+1.day, assignee_id: User.last.id , user_id: User.last.id}
      ])
  end

  describe 'filters tasks' do |variable|
    context "into upcoming tasks by group" do
      it 'returns four tasks' do
        users
        tasks
        expect(Task.upcoming_tasks(1).count).to eq 4
      end
    end
    context "into unassigned tasks" do   
      it 'returns one task' do
        users
        tasks
        expect(Task.unassigned(Task.all).count).to eq 1
      end
    end
    context 'assigns tasks to a user' do
      it 'returns number of tasks per user' do
        users
        tasks
        assert_equal Task.assigned_to_specific_user(Task.all, User.first).count, 1
        assert_equal Task.assigned_to_specific_user(Task.all, User.find(User.first.id+1)).count, 2
      end
    end

  end  
  describe 'analyzes data for charts ' do
    it 'creates a hash with four elements' do
      users
      tasks
      categories = Task.categories_per_month(1)
      assert_equal categories.class, Hash
      assert_equal categories.count, 3
    end
    it 'converts hash into array of arrays chart' do
      users
      tasks
      categories = Task.categories_per_month(1)
      chart_array=Task.bar_chart_array(categories)
      assert_equal chart_array.class, Array
      assert_equal chart_array.count, 8
      assert_equal chart_array[0], 2
      assert_equal chart_array[3], 1
      assert_equal chart_array[5], 1
      assert_equal chart_array[1], 0
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