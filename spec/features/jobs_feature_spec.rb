require 'rails_helper'

describe 'jobs index page' do
	it 'no jobs available yet.' do
		visit '/jobs'
		expect(page).to have_content 'No jobs inserted yet.'
	end

	it 'a job is available.' do
		job = Job.create name: 'Test job name', category: 'Bar', company: 'Test company', full_time: 'true', detail: 'Detailed description', location: 'EC2', pay: 10, email: 'employer@test.com', phone: '12345678'	
		visit '/jobs'
		expect(page).to have_content 'Test job name Bar Test company Detailed description EC2 10£ employer@test.com 12345678' 
	end
end

describe 'posting jobs' do
	context 'user logged out' do
		it 'it is redirected to the login page' do
			visit '/jobs/new'
			fill_in 'Name', with: 'Test job name'
			select 'Bar', from: 'Category'
			fill_in 'Company', with: 'Test Company'
			select 'Full Time', from: 'Full time'
			fill_in 'Detail', with: 'Detailed description'
			fill_in 'Location', with: 'EC2'
			fill_in 'Pay', with: 10
			fill_in 'Email', with: 'employer@test.com'
			fill_in 'Phone', with: '12345678'
			click_button 'Post a job'
			expect(current_path).to eq '/employers/sign_in'
			expect(page).to have_content 'Sign in'
		end
	end

	

	context 'logged in' do

		before do
			employer = Employer.create email: 'test@test.net', password: '12345678', password_confirmation: '12345678'
			login_as employer
		end
		
		it 'a post is created' do
			visit '/jobs/new'
			fill_in 'Name', with: 'Test job name'
			select 'Bar', from: 'Category'
			fill_in 'Company', with: 'Test Company'
			select 'Full Time', from: 'Full time'
			fill_in 'Detail', with: 'Detailed description'
			fill_in 'Location', with: 'EC2'
			fill_in 'Pay', with: 10
			fill_in 'Email', with: 'employer@test.com'
			fill_in 'Phone', with: '12345678'
			click_button 'Post a job'
			expect(current_path).to eq '/jobs'
			expect(page).to have_content 'Test job name Bar Test Company Detailed description EC2 10£ employer@test.com 12345678'
		end
	end
end


