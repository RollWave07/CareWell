class Group < ActiveRecord::Base
  has_many :users

  mount_uploader :picture, ImageUploader

  # def to_param
  #   "#{id} #{name}".parameterize
  # end

end
