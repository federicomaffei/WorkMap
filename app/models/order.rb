class Order < ActiveRecord::Base

  belongs_to :employer
  belongs_to :job
  after_create :send_confirmation_email

	def send_confirmation_email
  	OrderMailer.confirmation(self).deliver
 	end


end
