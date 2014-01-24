class TopMembersQuery
  def last_month(*options)
    execute 1.month.ago..Time.now, *options
  end

  def last_week(*options)
    execute 1.week.ago..Time.now, *options
  end

  def execute(time_period, relation = User)
    relation.where(
      id: Task.where(task_date: time_period)
              .group(:assignee_id)
              .select(:assignee_id)
              .order("count(*) ASC")
    )
  end
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

