class SubmissionsController < ApplicationController

	def new
	end

	def create
		@submission = Submission.new(submission_params)

		if @submission.valid?
			@submission.user = current_user
			@submission.save
			redirect_to jobs_path
		else
			flash[:notice] = 'Errors in your form'
			render 'new'
		end

	end

	def submission_params
		params[:submission].permit(:email, :message, :cv)
	end


end
