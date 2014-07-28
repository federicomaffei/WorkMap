class JobMailer < ActionMailer::Base
  default from: "no-reply@workmap.com"

  def cancellation(job)
  	@job = job
  	mail(to: job.employer.email, subject: "'#{job.advert_title}' advert removed")
  end

end
