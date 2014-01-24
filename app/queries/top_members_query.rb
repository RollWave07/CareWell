class TopMembersQuery
  # def last_month(*options)
  #   execute 1.month.ago..Time.now, *options
  # end

  # def last_week(*options)
  #   execute 1.week.ago..Time.now, *options
  # end


  # def execute(time_period)
  #   # users.sort(&:tasks_completed).last(5)

  #   # Task.where(task_date: time_period).group(:assignee_id).select(:assignee_id).order("count(*) ASC")
  # end

  # def top_users_list
  #   ActiveRecord::Base.connection.execute('select users.first_name, users.last_name, users.picture, count(*) as cnt from users inner join (SELECT * FROM tasks WHERE task_date < NOW()) t on users.id = t.assignee_id group by users.id order by cnt desc')
  # end

  def top_users_list(days)
    ActiveRecord::Base.connection.execute("select users.first_name, users.last_name, users.picture, count(*) as cnt from users inner join (SELECT * FROM tasks WHERE task_date BETWEEN now()::date - #{days} AND NOW()) t on users.id = t.assignee_id group by users.id order by cnt desc")
  end



  #FIXME: finds multiple records of Active Record
  # def most_helpful_order
  #   id_array = []
  #   Task.group(:assignee_id).select(:assignee_id).order("count(*) DESC").each do | id|
  #     id_array << id.assignee_id if id.assignee_id
  #   end 
  #   id_array  
  # end

  # def match_order_with_user
  #   users_array = []
  #   id_array.each do |id|
  #     users_array << User.where(id: id)
  #   end
  #   users_array
  # end

  # users_array.each do |user|
  #   puts user.first.first_name 
  # end

  #FIXME: Does not sort properly
  # def execute(time_period, relation = User)
  #   relation.where(
  #     id: Task.where(task_date: time_period)
  #             .group(:assignee_id)
  #             .select(:assignee_id)
  #             .order("count(*) ASC")
  #   )
  # end
end








# Para exemplar
# TopMembersQuery.new.last_month
# TopMembersQuery.new.execute(1.day.ago..Time.now, User.limit(5))
# TopMembersQuery.new.last_month(User.limit(10))


#  def execute(time_period, relation = User)
#     relation.where(
#       id: Task.where(task_date: time_period).select(:assignee_id)
#     )
#   end
# end

# SELECT "users".*, result.* FROM "users", (SELECT assignee_id, count(*) FROM "tasks" WHERE ("tasks"."task_date" BETWEEN '2013-12-23 21:05:01.950919' AND '2014-01-23 21:05:01.963152') GROUP BY assignee_id) as result join "users"."id" on result.assignee_id;                                                                                         

