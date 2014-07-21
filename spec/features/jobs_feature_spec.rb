require 'rails_helper'

feature 'jobs index page' do
	scenario 'no jobs available yet.' do
		visit '/jobs'
		expect(page).to have_content 'No jobs inserted yet.'
	end
	scenario 'a job is available.' do
		job = Job.create name: 'Test job name', category: 'Test category', company: 'Test company', full_time: 'true', detail: 'Detailed description', location: 'EC2', pay: 20
		visit '/jobs'
		expect(page).to have_content 'Test job name Test category Test company EC2 20' 
	end
end