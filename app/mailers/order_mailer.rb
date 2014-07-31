class OrderMailer < ActionMailer::Base
  default from: "from@example.com"

  def application(application)
    mail(to: application.email, subject: "#{}")
  end
  
end
