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
		@job = Job.new(params[:job].permit(:advert_title, :category, :company, :full_time, :detail, :address, :wage, :email, :phone))
		@job.employer = current_employer
		@job.save!
		redirect_to '/jobs'
	end
end
