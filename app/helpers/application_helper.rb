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

end
