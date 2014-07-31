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

	def job
		@job ||= Job.new
	end

	# def devise_mapping
	# 	@devise_mapping ||= Devise.mappings[:employer]
	# end

	def randomized_background_image
		images = ["https://dl.dropboxusercontent.com/u/9315601/backgrounds/bar.jpg", "https://dl.dropboxusercontent.com/u/9315601/backgrounds/restaurant2.jpg", "https://dl.dropboxusercontent.com/u/9315601/backgrounds/restaurant3.jpg"]
		images[rand(images.size)]
	end


  # def bootstrap_class_for(flash_type)
  #   case flash_type
  #     when "success"
  #       "alert-success"   # Green
  #     when "error"
  #       "alert-danger"    # Red
  #     when "alert"
  #       "alert-warning"   # Yellow
  #     when "notice"
  #       "alert-info"      # Blue
  #     else
  #       flash_type.to_s
  #   end
  # end

end
