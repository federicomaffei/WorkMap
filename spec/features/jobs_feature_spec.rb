require 'rails_helper'

feature 'jobs index page' do
	scenario 'no jobs available yet.' do
		visit '/jobs'
		expect(page).to have_content 'No jobs inserted yet.'
	end

	scenario 'a job is available.' do
		job = Job.create name: 'Test job name', category: 'Bar', company: 'Test company', full_time: 'true', detail: 'Detailed description', location: 'EC2', pay: 10
		visit '/jobs'
		expect(page).to have_content 'Test job name Bar Test company Detailed description EC2 10£' 
	end
end

feature 'posting jobs' do
	scenario 'a job is posted' do
		visit '/jobs/new'
		fill_in 'Name', with: 'Test job name'
		select 'Bar', from: 'Category'
		fill_in 'Company', with: 'Test Company'
		select 'Full Time', from: 'Full time'
		fill_in 'Detail', with: 'Detailed description'
		fill_in 'Location', with: 'EC2'
		fill_in 'Pay', with: 10
		click_button 'Post a job'
		expect(current_path).to eq '/jobs'
		expect(page).to have_content 'Test job name Bar Test Company Detailed description EC2 10£'
	end
end



