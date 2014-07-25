require 'rails_helper'

describe 'jobs index page' do
	
	it 'no jobs available yet.' do
		visit '/jobs'
		expect(page).to have_content 'No jobs inserted yet.'
	end

	it 'a job is available.' do
		job = Job.create advert_title: 'Test job name', category: 'Bar', company: 'Test company', full_time: 'true', detail: 'Detailed description', address: 'EC2', wage: 10, email: 'employer@test.com', phone: '12345678'	
		visit '/jobs'
		expect(page).to have_content 'Test job name Bar // Test company // Detailed description // EC2 // £10 per hour // employer@test.com // 12345678' 
	end
end

describe 'posting jobs' do

	context 'logged out' do 

		it 'it is redirected to the login page' do
			visit '/jobs'
			click_link 'Create a job'
			expect(current_path).to eq '/employers/sign_in'
		end

	end
	
	context 'logged in' do

		before do
			employer = Employer.create id: 1, email: 'test@test.net', password: '12345678', password_confirmation: '12345678'
			login_as employer
		end
		
		it 'a post is created', js: true do
			visit '/jobs/new'
			fill_in 'Advert title', with: 'Lady of the night'
			select 'Bar', from: 'Category'
			fill_in 'Company', with: 'Test Company'
			select 'Full Time', from: 'Full time'
			fill_in 'Detail', with: 'Detailed description'
			fill_in 'Address', with: 'EC2'
			fill_in 'Wage', with: 10
			fill_in 'Email', with: 'employer@test.com'
			fill_in 'Phone', with: '12345678'
			click_button 'Post a job'
			expect(page).to have_content "Amount: $5.00"
			click_button('Pay with Card')

			sleep 2
			
			 stripe = page.driver.window_handles.last
			 page.within_window stripe do
				fill_in('email', with: 'test@test.com')
				fill_in('card_number', with: '4242424242424242')
				fill_in('cc-exp', with: '0120')
				fill_in('cc-csc', with: '123')
				sleep 1
				click_button "Pay $5.00"
				sleep 5
			end
			# expect(current_path).to eq "/employers/1/adverts"
			puts page.html
			
			expect(page).to have_content 'Lady of the night'
		end
	end

end

describe 'employers viewing their job advertisments' do 

	context 'logged in as employer with one job advert among many' do

		before do
			@employer = Employer.create email: 'test@test.net', password: '12345678', password_confirmation: '12345678'
			login_as @employer
			@employer.jobs.create!(advert_title: 'Test job name 1', company: 'Test company', full_time: 'true', detail: 'Detailed description', address: 'EC2', wage: 5, email: 'email@test.com')
			Job.create!(advert_title: 'Test job name 2', company: 'Test company', full_time: 'true', detail: 'Detailed description', address: 'EC2', wage: 5, email: 'email@test.com')
		end
		
		it 'a post is created' do
			visit "/employers/#{@employer.id}/adverts"
			expect(page).to have_content 'Test job name 1'
			expect(page).not_to have_content 'Test job name 2'
		end
		
	end

end










