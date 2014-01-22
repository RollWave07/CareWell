class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :group
  mount_uploader :picture, ImageUploader

  has_many :tasks
  has_many :updates
  
  acts_as_voter

  def self.users_in_group(group)
    group.users
  end
  
end
