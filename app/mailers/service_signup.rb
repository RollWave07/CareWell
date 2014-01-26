class ServiceSignup < ActionMailer::Base
  default from: "hello@carewelldesign.com"

  def welcome(group, user)
    @group = group
    @user = user
    @greeting = "Welcome to CareWell!"

    mail( to: user.email, subject: "Thanks for Signing Up!")
  end

end
