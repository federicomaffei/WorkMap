class JobsController < ApplicationController

	before_action :authenticate_employer!, except: [:index]

	def index
		@jobs = Job.all
	end

	def new
		@job = Job.new
	end

	def create
		# raise 'helo'
		@job = Job.new(job_params)
		if @job.valid?
			@job.employer = current_employer
			@job.save
			redirect_to new_job_charge_path(@job)
		else
			flash[:notice] = 'Errors in your form'
			render 'new'
		end
		# redirect_to '/charges/new'
		# puts session[:temp_job]
		# raise 'hello'
		
		# @job = Job.new(job_params)
		# @job.employer = current_employer
		# @job.save!
		# redirect_to '/jobs'
	end

	def update
		job = Job.find params[:id]
		job.update(job_params)
		redirect_to employer_adverts_path(job)
	end

	private

	def job_params
		params[:job].permit(:advert_title, :category, :company, :full_time, :detail, :address, :wage, :email, :phone)
	end
end
