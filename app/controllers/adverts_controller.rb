class AdvertsController < ApplicationController

	def index
		puts '################################################'
		# raise current_employer
		puts '################################################'
		@employer = current_employer
		@adverts = @employer.jobs
		puts @adverts.count
	end

	def edit
		@job = Job.find params[:id]
	end

	def destroy
		job = Job.find params[:id]
		job.destroy
		redirect_to '/' #change this redirect to if other adverts > employer_adverts_path, if not post advert page. 

	end

end
