class TasksController < ApplicationController

  before_action :find_group

  def send_email
    group_id = params[:group_id]
    inviter = current_user.first_name
    first_name = params[:first_name]
    last_name = params[:last_name]
    email = params[:email]
    task = params[:task]
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
    @update = Update.new
    @group = current_user.group
  end

  def show
    @task = Task.find(params[:id])
    @update = Update.new
  end

  def edit
    @task = Task.find(params[:id])
  end

  def new
    @task = current_user.tasks.new
  end

  def create

    @task = current_user.tasks.new(task_params)
    date = Chronic.parse(task_params[:task_date])
    @task.task_date = date ? date : Time.now+7.days

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
    @task = Task.find(params[:id])
    previous_task_date = @task.task_date
    date = Chronic.parse(task_params[:task_date])    
    @tasks = Task.tasks(@group).future
    @my_tasks = Task.assigned_to_specific_user(@tasks.future, current_user)
    @open_tasks = Task.unassigned(@tasks)

    old_assignee_id = @task.assignee_id
    @task.assignee_id = task_params[:assignee_id]
    respond_to do |format|
      if @task.update(task_params)
        @task.task_date = date ? date : previous_task_date
        if @task.save
          format.json { render json:{assignee_name: @task.assignee.first_name}}
          format.html { redirect_to group_tasks_path(@group), notice: 'task was successfully updated.' }
          format.js { render layout: false, notice: "You've signed up for #{@task.title}."}  
          # send the mailer invitation on sign up  - taken out for demo - look into delayed_job gem.
          # if @task.assignee_id != old_assignee_id && @task.assignee != nil
          #   MailerInvitation.calendar_invite(@task).deliver
          # end
        end  
      else
        format.html { render action: 'edit' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def mark_complete
    @task = Task.find(params[:id])
    @task.status = "complete"
    @task.save
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
    params.fetch(:task, {}).permit(:category, :title, :information, :start_time, :duration, :task_date, :user_id, :assignee_id, :groupid)
   end
end
