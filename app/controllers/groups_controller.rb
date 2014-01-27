class GroupsController < ApplicationController
  protect_from_forgery with: :exception

  before_action :set_group, only: [:show, :edit, :update, :destroy]

  def index
    @groups = Group.all
  end

  def show
    @users = User.where(group_id: params[:id])
  
    @assigned_tasks = Task.assigned(@group)
   
    @counts_arrays = Task.count_per_period(@assigned_tasks)
    # @top_three_members = TopMembersQuery.new.top_users_list(30)

    @last_three_tasks_completed = Task.last_three_tasks_completed(@assigned_tasks)
    @category_avg = Task.average_duration_per_category(@assigned_tasks)

    @group_count = User.where(group_id: current_user.group_id).count

    @group_created_at = Group.find(current_user.group_id).created_at.strftime('%B %e, %Y')

    @categories_per_month_array = Task.bar_chart_array(@group.id)

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
