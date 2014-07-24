class JobsController < ApplicationController

	before_action :authenticate_employer!, except: [:index, :show]

	def index
		if params.include?(:full_time)
			filtered_by(params)
		else
			@jobs = Job.all
		end

	end

	def new
		@job = Job.new
	end

	def create
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
		redirect_to '/'
	end

private

	def job_params
		params[:job].permit(:advert_title, :category, :company, :full_time, :detail, :address, :wage, :email, :phone)
	end

	def filtered_by(params)
		job_search_array = [params[:bar_box], params[:cafe_box], params[:hotel_box], params[:restaurant_box], params[:shop_box], params[:strip_box]].compact
		# @jobs = Job.where({ category: job_search_array, full_time: params[:full_time], wage: params[:wage].permit(:min_wage)})
		@jobs = Job.where({ category: job_search_array })
		return @jobs
	end
end
