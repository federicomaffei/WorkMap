class UserWelcomeMailer < ActionMailer::Base
  default from: "no-reply@workmap.com"

  def user_welcome(user)
  	@user = user
  	mail(to: user.email, subject: "Thanks #{user.email} for signing up")
  end
  

  # def cancellation
    
  # end

  # def status_change
  # end

  # def refunded
  # end


end
