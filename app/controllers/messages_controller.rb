class MessagesController < ApplicationController
  # before_action :authenticate_user!
  before_filter :find_group #maybe before_filter


  def index
  end

  def show
  end

  def edit
  end

  def new
    @message = Message.new
  end

  def create

    @message = Message.new(message_params)
    @message.user_id = current_user.id
    respond_to do |format|
      if @message.save
        format.html { redirect_to group_path(@group), notice: 'update was successfully created.' }
        format.json { render action: 'show', status: :created, location: @message }
      else
        format.html { render action: 'new' }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @message = Message.find(params[:id])
    respond_to do |format|
      if @message.destroy
        format.json { render json:{message: @message.id}}
        format.html { redirect_to :back, notice: "message was deleted"  }
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

  def message_params
    params.require(:message).permit(:message_text, :photo, :user_id, :group_id)
  end

end
