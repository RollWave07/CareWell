class TasksController < ApplicationController

  before_action :find_group

  def send_email
    group_id = params[:group_id]
    inviter = current_user.first_name
    first_name = params[:first_name]
    last_name = params[:last_name]
    email = params[:email]
    task= params[:task]
    result = Userinvite.invite(group_id, inviter, first_name, last_name, email, task).deliver
    respond_to do |format|
      if result
        format.html { redirect_to group_tasks_path(group_id), notice: 'Message sent successfully' }
      else
        format.html { redirect_to group_tasks_path(group_id), notice: 'Message NOT sent successfully' }
      end
    end

    # format.html { notice: 'Message sent successfully' }
  end


  def index
    @tasks = Task.tasks(@group).future
    @my_tasks = Task.assigned_to_specific_user(@tasks.future, current_user)
    @open_tasks = Task.unassigned(@tasks)

    @commenter_name = current_user.first_name
    @commenter_picture = current_user.picture

    @group_name = @group.name

    @update = Update.new
  end

  def show
    @task = Task.find(params[:id])
    @group = Group.find(params[:group_id])
    @update = Update.new
  end

  def edit
    @task = Task.find(params[:id])
  end

  def new
    @group = Group.find(params[:group_id])
    @task = current_user.tasks.new
  end

  def create
    @task = current_user.tasks.new(task_params)
    respond_to do |format|
      if @task.save
        format.html { redirect_to group_tasks_path(@group), notice: 'Task was successfully created.' }
        format.json { render action: 'show', status: :created, location: @task }
      else
        format.html { render action: 'new', alert: 'Unable to add the task.  Please try again.' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @my_tasks = Task.where(assignee_id: current_user.id)
    @open_tasks = Task.where(assignee_id: nil)
    @task = Task.find(params[:id])
    old_assignee_id = @task.assignee_id
    @task.assignee_id = params[:assignee_id]
    respond_to do |format|
      if @task.update(task_params)
        format.json { render json:{assignee_name: @task.assignee.first_name}}
        format.html { redirect_to group_tasks_path(@group), notice: 'task was successfully updated.' }
        format.js { render layout: false, notice: "You've signed up for #{@task.title}."}
        # send the mailer invitation on sign up
        if @task.assignee_id != old_assignee_id && @task.assignee != nil
          MailerInvitation.calendar_invite(@task).deliver
        end
      else
        format.html { render action: 'edit' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end

  end

  private

  def find_group
    if current_user.group
      @group = current_user.group
    else
      @group = Group.find(params[:group_id])
    end
  end

  def task_params
      params.fetch(:task, {}).permit(:category, :title, :information, :start_time, :duration, :task_date, :user_id, :assignee_id)
    end
end
