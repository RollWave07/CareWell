class TasksController < ApplicationController

  before_action :find_group

  def send_email
    inviter_first = current_user.first_name
    inviter_last = current_user.last_name
    first_name = params[:first_name]
    last_name = params[:last_name]
    email = params[:email]
    result = Userinvite.invite(@group, inviter_first, inviter_last, first_name, last_name, email).deliver
    respond_to do |format|
      if result
        format.html { redirect_to :back, notice: 'Message sent successfully' }
      else
        format.html { redirect_to :back, notice: 'Message NOT sent successfully' }
      end
    end
    # format.html { notice: 'Message sent successfully' }
  end

  def index
    @date = params[:month] ? Date.parse(params[:month]) : Date.today
    @user = User.find(current_user.id)
    @tasks = Task.tasks(@group).future
    @past_tasks = Task.tasks(@group).past.limit(5)
    @others_tasks = Task.tasks(@group).future.where.not(assignee_id: nil, assignee_id: current_user)
    @my_tasks = Task.assigned_to_specific_user(@tasks.future, current_user)
    @past_user_tasks = Task.assigned_to_specific_user(@tasks.past, @user)
    @open_tasks = Task.tasks(@group).future.where(assignee_id: nil)
    @this_months_events = Event.events(@group).from_this_month
    @update = Update.new
  end

  def show
    @task = Task.find(params[:id])
    @update = Update.new
  end

  def edit
    @task = Task.find(params[:id])
    @users = User.users_in_group(@group)
  end

  def new
    @task = current_user.tasks.new
    @users = User.users_in_group(@group)
  end

  def create

    @task = current_user.tasks.new(task_params)
    date = Chronic.parse(task_params[:task_date])
    @task.task_date = date ? date : Time.now+7.days

    if @task.assignee_id == 1
      @task.assignee_id = current_user.id
    else
      @task.assignee_id = nil
    end

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
          if @task.assignee_id != old_assignee_id && @task.assignee != nil
            MailerInvitation.calendar_invite(@task).deliver
            MailerInvitation.task_sign_up_notification(@task).deliver
          end
        end
      else
        format.html { render action: 'edit' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
    end
  end

  def mark_complete
    @task = Task.find(params[:id])
    if @task.status == "complete"
      @task.status = "incomplete"
    elsif @task.status == "incomplete"
      @task.status = "complete"
    else
      @task.status = "complete"
    end
    @task.save
    respond_to do |format|
      format.js {render layout: false}
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
    params.fetch(:task, {}).permit(:category, :title, :information, :start_time, :duration, :location, :task_date, :user_id, :assignee_id, :groupid)
   end
end
