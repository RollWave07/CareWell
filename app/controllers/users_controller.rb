class UsersController < ApplicationController
  before_action :authenticate_user!

  #Carrierwave - Add support for uploaded images 
  mount_uploader :profile_pic, ImageUploader

  def index
    @users = User.all
  end

end
