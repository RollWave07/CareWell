class UpdatesController < ApplicationController
  before_action :authenticate_user!
  # before_filter :find_task

  # def index
  #   @updates = current_user.updates
    # @commenter_name = current_user.first_name
    # @commenter_picture = current_user.picture
    # @group_name = Group.find(current_user.group_id).name
  # end

  # def show
  # end

  # def edit
  #   @update = Update.find(params[:id])
  # end

  # def create
  #   @update = Update.new(update_params)
  #   current_user.group = @group
  #   respond_to do |format|
  #     if @update.save
  #       format.html { redirect_to update_path(@group), notice: 'your comment was successfully saved.' }
  #       format.js { render layout: false }
  #     else
  #       format.html { render action: 'new' }
  #     end
  #   end
  # end

  # def update
  #   respond_to do |format|
  #     if @group.update(group_params)
  #       format.html { redirect_to @group, notice: 'group was successfully updated.' }
  #     else
  #       format.html { render action: 'edit' }
  #     end
  #   end
  # end

  def new
  end

  private
  # def find_task
  #   @task = task.find(params[:task_id])
  # end

  # def update_params
  #     params.require(:update).permit(:comment, :picture, :task_id, :user_id)
  end
end
