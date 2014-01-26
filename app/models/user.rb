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
    group.users
  end


  # TODO:
  # FIXME:
  #   Does not actually limit to tasks which have been completed.
  # def tasks_completed(params = {})
  #   find_params = { assignee_id: id }
  #   find_params[:task_date] = params[:since]..Time.now if params[:since]

  #   Task.where(find_params).count
  # end

  
  # my_user.tasks_completed(task_date: 1.month.ago..Time.now)
  # my_user.tasks_completed(since: 1.month.ago)

  # #top users last week:
  # def self.users_with_tasks_last_month
  #   #this is for the user_id and I want assignee_id
  #   binding.pry
  #   self.joins(:tasks, foreign_key: :assignee_id).where(tasks: {task_date:(31.day.ago..Time.now)})
  # end

  # def self.find_assignee_with_tasks_last_month
  #   self.includes(:tasks).where(tasks: {task_date:(31.day.ago..Time.now)})
  # end




  # def self.tasks_per_member(tasks)
  #   memberstats = {}
  #   tasks.each do |task|
  #     if memberstats[task.assignee]
  #       memberstats[task.assignee] += 1
  #     else
  #       memberstats[task.assignee] = 1
  #     end
  #   end
  #   memberstats
  # end

  # def self.format_name(hash)
  #   hash.map { |k, v| k="#{k.first_name} #{k.last_name}", v }
  # end

  # def self.format_date(date)
  #   date.strftime("%a, %b %d")
  # end

  # def self.sort_by_value(hash)
  #   hash.sort_by { |a, b| b }
  # end

  # def self.top_three(value)
  #   i=0
  #   the_top_three = []
  #   while i<3
  #     the_top_three << value[i] if value[i]
  #     i+=1
  #   end
  #   the_top_three
  # end

end
