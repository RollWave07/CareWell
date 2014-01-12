class Userinvite < ActionMailer::Base
  default from: "hello@carewelldesign.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.userinvite.invite.subject
  #
  def invite
    @greeting = "Hi"

    mail to: "briansisney@gmail.com", subject: "Test"
  end
end
