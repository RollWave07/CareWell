class MailerInvitation < ActionMailer::Base
  default from: "hello@carewelldesign.com"

  # Include the task information, as well as the assignee users email and name.

  def event(task, group_id)
  # assignee information (from task)
    @first_name = task.assignee.first_name
    @last_name = task.assignee.last_name
    @email  = task.assignee.email
  #task information
    @task = task
    @task_title = task.title
    @task_category = task.category
    @task_information = task.information
    @task_date = task.task_date.strftime('%A, %B %e, %Y')
  #group information
    @group = group_id



    @greeting = "Hi " + task.assignee.first_name + ','
    mail( to: @email, subject: @task.title)

  end
end
