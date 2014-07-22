class JobsController < ApplicationController

	def index
		# if params[:employer_id]
		# 	@employer = Employer.find params[:employer_id]
		# 	@jobs = @employer.jobs
		# else
			@jobs = Job.all
		# end
	end

	def new
		authenticate_employer!
		@job = Job.new
	end

	def create
		authenticate_employer!
		@job = Job.new(params[:job].permit(:name, :category, :company, :full_time, :detail, :location, :pay, :email, :phone))
		@job.employer = current_employer
		@job.save!
		redirect_to '/jobs'
	end
end
