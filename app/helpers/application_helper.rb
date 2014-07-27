module ApplicationHelper
	
	def employer_name
		:employer
	end

	def user_name
		:user
	end

	def employer
		@employer ||= Employer.new
	end

	def user
		@user ||= User.new
	end

	# def devise_mapping
	# 	@devise_mapping ||= Devise.mappings[:employer]
	# end

	def randomized_background_image
		images = ["https://dl.dropboxusercontent.com/u/9315601/backgrounds/bar.jpg", "https://dl.dropboxusercontent.com/u/9315601/backgrounds/restaurant2.jpg", "https://dl.dropboxusercontent.com/u/9315601/backgrounds/restaurant3.jpg"]
		images[rand(images.size - 1)]
	end

end
