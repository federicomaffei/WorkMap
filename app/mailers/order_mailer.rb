class OrderMailer < ActionMailer::Base
  default from: "no-reply@workmap.com"

  def confirmation(order)
  	@order = order
  	mail(to: order.employer.email, subject: "'#{order.job.advert_title}' placement confirmed")
  end

  # def cancellation
  # end

  # def status_change
  # end

  # def refunded
  # end


end
