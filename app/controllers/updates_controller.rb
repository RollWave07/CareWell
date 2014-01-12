class UpdatesController < ApplicationController
  before_action :authenticate_user!
  before_filter :find_group #maybe before_filter

  def index
  end

  def show
  end

  def edit
  end

  def new
    @update = Update.new
  end

  def create
    @update = Update.new(update_params)
    @update.user_id = current_user.id
    respond_to do |format|
      if @update.save
        format.html { redirect_to group_tasks_path(@group), notice: 'update was successfully created.' }
        format.json { render action: 'show', status: :created, location: @update }
        format.js { render layout: false }
      else
        format.html { render action: 'new' }
        format.json { render json: @update.errors, status: :unprocessable_entity }
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

  def update_params
          params.require(:update).permit(:comment, :picture, :task_id, :user_id)
  end

end
