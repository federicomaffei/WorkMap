class AdvertsController < ApplicationController

	def index
		@employer = current_employer
		@adverts = @employer.jobs
	end

	def edit
		@job = Job.find params[:id]
	end

	def destroy
		job = Job.find params[:id]
		job.destroy
		redirect_to '/'
	end

end
