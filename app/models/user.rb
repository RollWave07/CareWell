class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :group
  mount_uploader :picture, ImageUploader

  # scope :future, lambda {where(["task_date > ?", Time.now])}
  # scope :past, lambda {where(["task_date < ?", Time.now])}

  has_many :tasks
  has_many :updates

  acts_as_voter

  def self.users_in_group(group)
    self.where(group_id: group.id)
  end

  def self.user_array(group)
    array = []
    users = self.where(group_id: group.id)
    users.each do |user|
      array << [user.first_name]
    end
    puts array
  end


end
