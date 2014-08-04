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

  def self.top_users_per_week(group)
    users = self.where(group_id: group)
    user_array = []
    users.each do |user|
      task_count = user.tasks.week_one.count
      user_array << {user.first_name => task_count}
    end
    sorted_array = user_array.sort_by {|k,v| v}
    sorted_array[0..2]
  end

  def self.active_users_per_week(group)
    users = User.where(group_id: group.id)
    active = 0
    users.each do |user|
      if user.tasks.week_one.count > 0
        active += 1
      elsif user.updates.week_one.count > 0
        active += 1
      elsif user.votes.where(created_at:(7.day.ago..Time.now)).count > 0
        active += 1
      end
    end
    active
  end

end
