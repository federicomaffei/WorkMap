class JobsController < ApplicationController

	def index
		@jobs = Job.all
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
