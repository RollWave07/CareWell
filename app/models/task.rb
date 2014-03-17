class Task < ActiveRecord::Base

  belongs_to :user
  # belongs_to :group
  belongs_to :assignee, :class_name => "User"
  # belongs_to :location
  has_many :updates


  validates :title, presence: true


  scope :completed_recently, lambda { where(task_date: 1.day.ago..Time.now) }

  #this month's tasks
  scope :from_this_month, lambda {where(task_date: Time.now.at_beginning_of_month..Time.now.at_end_of_month)}
  #___GRAPH DATA
  scope :future, lambda {where(["task_date > ?", Time.now])}
  scope :past, lambda {where(["task_date < ?", Time.now])}

  scope :week_one, lambda {where(task_date:(7.day.ago..Time.now))}
  scope :week_two, lambda {where(task_date:(14.day.ago..8.day.ago))}
  scope :week_three, lambda {where(task_date:(21.day.ago..15.day.ago))}
  scope :week_four, lambda {where(task_date:(28.day.ago..22.day.ago))}

  @scopes_period = ["week_one", "week_two", "week_three", "week_four"]

  def self.count_per_period(tasks, time_period = @scopes_period)
    output_array = []
    time_period.each do |time|
      output_array << tasks.send("#{time}").count
    end
    output_array
  end

  def self.categories_per_month(groupid)
    self.where(groupid: groupid).select(:category).group(:category).count
  end

# Task.categories_per_month(groupid)

  def self.bar_chart_array(task_hash)
    categories = ["getting places", "around the home", "shopping", "meals", "personal care", "odds & ends", "visits & outings", "remote"]
    answer = []
    categories.each do |category|
      if task_hash[category]
        answer << task_hash[category].to_i
      else
        answer << 0
      end
    end
    answer
  end



  def ordered_updates
    self.updates.order("created_at")
  end

  def likes_count
    total = 0
    self.updates.each do |update|
      total += update.likes.count
    end
    total
  end

  def self.duration_total_past_week(tasks)
    tasks.week_one.inject(0) { |mem, var|  mem + var.duration}/60
  end


  def self.tasks(group)
    self.includes(:updates).joins(:user).where(:users => {group_id: group})
  end

  #finds 1 month of future tasks
  # this is a test!!
  def self.upcoming_tasks(group)
    tasks = self.joins(:user).where(:users => {group_id: group})
    tasks.where(task_date:(Time.now..Time.now+31.day))
  end

  #finds tasks that are not assigned to an assignee(user)
  def self.unassigned(tasks)
    self.assigned_to_specific_user(tasks, nil)
  end

  def self.assigned_to_specific_user(tasks, user)
    tasks.select do |task|
      task.assignee == user
    end
  end
  # def self.assigned_to_specific_user(tasks, user)
  #   tasks.select do |task|
  #     task.assignee.id == user
  #   end
  # end

  # def self.assigned(tasks)
  #   tasks.select do |task|
  #     task.assignee != nil
  #   end
  # end

  #this needs to be different so that the scope works
  def self.assigned(group)
    Task.tasks(group).where.not(assignee_id: nil)
  end
  def self.last_three_tasks_completed(tasks)
    tasks.limit(3).where(task_date: 1.month.ago..Time.now).order(task_date: :desc)
  end

  def self.average_duration_per_category(tasks)
    tasks.group(:category).select(:category, :duration).average(:duration)
  end

end
