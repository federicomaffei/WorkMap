class JobsController < ApplicationController

	before_action :authenticate_employer!, except: [:index]

	def index
		@jobs = Job.all
	end

	def new
		@job = Job.new
	end

	def create
		@job = Job.new(job_params)
		@job.employer = current_employer
		@job.save!
		redirect_to '/jobs'
	end

	def update
		job = Job.find params[:id]
		job.update(job_params)
		redirect_to '/'
	end

	private

	def job_params
		params[:job].permit(:advert_title, :category, :company, :full_time, :detail, :address, :wage, :email, :phone)
	end
end
