class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_group
  #Carrierwave - Add support for uploaded images
  # mount_uploader :profile_pic, ImageUploader

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @tasks = Task.tasks(@group)
    @past_user_tasks = Task.assigned_to_specific_user(@tasks.past, @user)
    @future_user_tasks = Task.assigned_to_specific_user(@tasks.future, @user)
  end

private
  def find_group
    if current_user.group
      @group = current_user.group
    else
      @group = Group.find(params[:group_id])
    end
  end
end
