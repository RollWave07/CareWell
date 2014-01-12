class Userinvite < ActionMailer::Base
  default from: "eric@carewelldesign.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.userinvite.invite.subject
  #
  def invite(group_id, inviter, first_name, last_name, email, task)
    @group_id = group_id
    @inviter = inviter
    @first_name = first_name
    @last_name = last_name
    @task = task
    @email = email
    
    mail( to: email, subject: task)
  end

end
