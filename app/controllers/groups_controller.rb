class GroupsController < ApplicationController
  protect_from_forgery with: :exception

  before_action :set_group, only: [:show, :edit, :update, :destroy]

  def index
    @groups = Group.all
  end

  def show
    @users = User.users_in_group(@group)

    @top3 = User.top_users_per_week(@group)

    @active_users = User.active_users_per_week(@group)

    @assigned_tasks = Task.assigned(@group)

    @counts_arrays = Task.count_per_period(@assigned_tasks)

    @category_avg = Task.average_duration_per_category(@assigned_tasks)

    @group_count = @users.count

    @group_created_at = @group.created_at.strftime('%B %e, %Y')

    @categories_per_month_array = Task.bar_chart_array(Task.categories_per_month(@group.id))

    @duration_chart_data = Task.bar_chart_array(@category_avg)

    @duration_week = Task.duration_total_past_week(@assigned_tasks)

    @message = Message.new
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
        format.json { respond_with_bip(@group) }
      else
        format.html { render action: 'edit' }
        format.json { respond_with_bip(@group) }
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
    params.require(:group).permit(:name, :picture)
  end
end
