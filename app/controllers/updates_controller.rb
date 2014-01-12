class UpdatesController < ApplicationController
  before_action :authenticate_user!
  #Carrierwave - Add support for uploaded images
  mount_uploader :profile_pic, ImageUploader

  def index
  end

  def show
  end

  def edit
  end

  def new
  end
end
