class JobsController < ApplicationController

	before_action :authenticate_employer!, except: [:index, :show]

	def index
		puts params
		if params[:refined]
			# puts params.inspect
			filtered_by(params)
			# @max_distance = 100.0
			@max_distance = params[:distance]
			render 'index', content_type: :json
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

	end

	def show
		@job = Job.find params[:id]
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

	def filtered_by(params)
		job_search_array = [params[:bar_box], params[:cafe_box], params[:hotel_box], params[:restaurant_box], params[:shop_box], params[:strip_box]].compact
		wage_range = params[:wage].to_i..100#params[:wage][1].to_i
		if (params[:full_time] == "true") || (params[:full_time] == "false")
			@jobs = Job.where({ category: job_search_array, wage: wage_range, full_time: params[:full_time] })
		else
			@jobs = Job.where({ category: job_search_array, wage: wage_range })			
		end
	end
	
end
