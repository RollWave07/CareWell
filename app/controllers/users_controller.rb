class UsersController < ApplicationController
  before_action :authenticate_user!, except: :email_available
  before_action :find_group, except: :email_available
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

  # Checks the database to see if email is available on sign-up
  #
  # Returns json object
  def email_available
    email_attempt = params[:email_attempt].downcase
    user = User.find_by_email(email_attempt)
    if user
      render :json => { :available => false}
    else
      render :json => { :available => true}
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
end
