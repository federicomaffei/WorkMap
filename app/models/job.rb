class Job < ActiveRecord::Base
	
	validates :name, presence: true
	validates :company, presence: true
	validates :location, presence: true
	validates :pay, numericality: { only_integer: true }
	validates :email, format: { with: /\A[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})\z/ }

end
