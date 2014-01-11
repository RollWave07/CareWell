class TasksController < ApplicationController
  before_action :authenticate_user!
  def index
    @group = Group.find(params[:group_id])
    @tasks = Task.joins(:user).where(:users => {group_id: @group})
  end

  def show

  end

  def edit
    @task = Task.find(params[:id])
  end

  def new
    @group = Group.find(params[:group_id])
    @task = Task.new
  end

  def create

  end

end
