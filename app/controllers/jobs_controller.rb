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
		@job = Job.new(job_params)
		@job.employer = current_employer
		@job.save!
		redirect_to '/jobs'
	end

	def update
		authenticate_employer!
		job = Job.find params[:id]
		job.update(job_params)
		redirect_to '/'
	end

	private

	def job_params
		params[:job].permit(:advert_title, :category, :company, :full_time, :detail, :address, :wage, :email, :phone)
	end
end
