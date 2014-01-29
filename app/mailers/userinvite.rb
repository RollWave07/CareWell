class Userinvite < ActionMailer::Base
  default from: "hello@carewelldesign.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.userinvite.invite.subject
  #
  def invite(group, inviter_first, inviter_last, first_name, last_name, email)
    @group_id = group.id
    @group_name = group.name
    @inviter_first = inviter_first
    @inviter_last = inviter_last
    @first_name = first_name
    @last_name = last_name
    @email = email
    mail( to: email, subject: "CareWell Invitation from #{@inviter_first} #{@inviter_last}")
  end

end
