class JobsController < ApplicationController

	def index
		@jobs = Job.all
	end

	def new
		@job = Job.new
	end

	def create
		@job = Job.create(params[:job].permit(:name, :category, :company, :full_time, :detail, :location, :pay))
		redirect_to '/jobs'
	end
end
