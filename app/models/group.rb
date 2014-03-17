class Group < ActiveRecord::Base
  has_many :users
  has_many :events

  mount_uploader :picture, ImageUploader

  # def to_param
  #   "#{id} #{name}".parameterize
  # end

end
