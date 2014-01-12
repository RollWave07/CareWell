class Userinvite < ActionMailer::Base
  default from: "eric@carewelldesign.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.userinvite.invite.subject
  #
  def invite(user, invitee)
    @greeting = "Hi"
    @groupid = user.group.id
    mail( to: invitee, subject: "Test")
  end
end
