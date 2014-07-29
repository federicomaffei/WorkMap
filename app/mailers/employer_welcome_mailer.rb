class EmployerWelcomeMailer < ActionMailer::Base
  default from: "no-reply@workmap.com"

  def employer_welcome(employer)
  	@employer = employer
  	mail(to: employer.email, subject: "Thanks #{employer.email} for signing up")
  end

  # def cancellation
    
  # end

  # def status_change
  # end

  # def refunded
  # end


end
