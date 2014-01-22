class GroupsController < ApplicationController
  protect_from_forgery with: :exception

  before_action :set_group, only: [:show, :edit, :update, :destroy]

  def index
    @groups = Group.all
  end

  def show
    @total_tasks = Task.tasks(@group)
    @total_tasks_count = @total_tasks.count
    @tasks_last_week = @total_tasks.last_week
    @tasks_last_month = @total_tasks.last_month
    @tasks_next_week = @total_tasks.next_week
    @tasks_next_month = @total_tasks.next_month

    @top_three_members_last_month = Task.top_three_members(@tasks_last_month)
    @top_three_members_last_week = Task.top_three_members(@tasks_last_week)

    @next_three_tasks = Task.next_three_tasks(@tasks_next_month)

    @last_three_tasks = Task.last_three_tasks(@tasks_last_month)



    @group_members = User.users_in_group(@group)
    @members_count = @group_members.count

  end

  def edit
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    respond_to do |format|
      if @group.save
        current_user.group = @group
        current_user.save
        format.html { redirect_to group_tasks_path(@group), notice: 'group was successfully created.' }
        format.js { render layout: false }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'group was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy

  end

  private

  def set_group
    if current_user.group
      @group = current_user.group
    else
      @group = Group.find(params[:id])
    end
  end
  def group_params
    params.require(:group).permit(:name)
  end
end
