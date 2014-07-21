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
		@job = Job.new(params[:job].permit(:name, :category, :company, :full_time, :detail, :location, :pay, :email, :phone))
		@job.employer = current_employer
		@job.save
		redirect_to '/jobs'
	end
end
