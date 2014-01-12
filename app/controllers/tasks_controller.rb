class TasksController < ApplicationController

  before_action :authenticate_user!
  before_filter :find_group #maybe before_filter

  def index
    @tasks = Task.joins(:user).where(:users => {group_id: @group})
    @commenter_name = current_user.first_name
    @commenter_picture = current_user.picture
    @group_name = Group.find(current_user.group_id).name
    @update = Update.new
  end

  def show

  end

  def edit
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    respond_to do |format|
      if @task.save
        format.html { redirect_to group_tasks_path(@group), notice: 'Task was successfully created.' }
        format.json { render action: 'show', status: :created, location: @task }
      else
        format.html { render action: 'new' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @task = Task.find(params[:id])
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to group_tasks_path(@group), notice: 'task was successfully updated.' }
        format.json { head :no_content }
        format.js { render layout: false }
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
      params.require(:task).permit(:category, :title, :information, :start_time, :duration, :task_date, :user_id, :assignee_id)
    end
end
