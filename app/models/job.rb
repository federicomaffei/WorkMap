class Job < ActiveRecord::Base
	
	validates :advert_title, presence: true, length: { maximum: 40, minimum: 5 }
	validates :company, presence: true, length: { maximum: 40, minimum: 3 }
	validates :address, presence: true
	validates :wage, numericality: { only_integer: true }
	validates :email, format: { with: /\A[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})\z/ }

	belongs_to :employer


	geocoded_by :address
	after_validation :geocode
	after_destroy :send_cancellation_email

	def send_cancellation_email
  	JobMailer.cancellation(self).deliver
  end

end
