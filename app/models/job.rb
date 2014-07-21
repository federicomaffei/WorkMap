class Job < ActiveRecord::Base
	
	validates :name, presence: true, length: { maximum: 40, minimum: 5 }
	validates :company, presence: true, length: { maximum: 40, minimum: 3 }
	validates :location, presence: true
	validates :pay, numericality: { only_integer: true }
	validates :email, format: { with: /\A[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})\z/ }

	belongs_to :employer

end
