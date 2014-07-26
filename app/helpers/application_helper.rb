module ApplicationHelper
	
	def resource_name
		:employer
	end

	def resource
		@resource ||= Employer.new
	end

	def devise_mapping
		@devise_mapping ||= Devise.mappings[:employer]
	end

	def randomized_background_image
		images = ["https://dl.dropboxusercontent.com/u/9315601/backgrounds/bar.jpg", "https://dl.dropboxusercontent.com/u/9315601/backgrounds/restaurant2.jpg", "https://dl.dropboxusercontent.com/u/9315601/backgrounds/restaurant3.jpg", "https://dl.dropboxusercontent.com/u/9315601/backgrounds/waiter.jpg"]
		images[rand(images.size)]
	end

end
