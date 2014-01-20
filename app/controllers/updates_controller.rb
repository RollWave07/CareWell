class UpdatesController < ApplicationController
  # before_action :authenticate_user!
  before_filter :find_group #maybe before_filter

  #Carrierwave - Add support for uploaded images
  # mount_uploader :profile_pic, ImageUploader


  # def receive_twilio_text
  #   group_id = params[:group_id]
  #   task_id = params[:task_id]
  #   # update_id = params[:update_id]
  # end

  def vote
    @update = Update.find(params[:id])
    @update.vote :voter => current_user, :vote => 'like'
    respond_to do |format|
      format.json { render json:{vote_id: @update.id, count: @update.votes.count, vote_type}}
      format.html {redirect_to root_url, notice: "Thank you for voting!"}
      # format.js { render layout: false }
    end
  end

  def unvote
    @update = Update.find(params[:id])
    @update.unliked_by current_user
    respond_to do |format|
      format.json { render json:{vote_id: @update.id, count: @update.votes.count}}
      format.html {redirect_to root_url}
    end
  end

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

  def destroy
    @update = Update.find(params[:id])
    respond_to do |format|
      if @update.destroy
        format.json { render json:{update: @update.id}}
        format.html { redirect_to :back, notice: "@update.comment was deleted"  }
        format.js { render layout: false }
      end
    end

    # respond_to do |format|
    #   format.json { render json:{vote_id: @update.id, count: @update.votes.count}}
    #   format.html {redirect_to :back, notice: "Thank you for voting!"}
    # end
    

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
