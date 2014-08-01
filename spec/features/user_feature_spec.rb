require 'rails_helper'

describe 'user signing up' do 

	scenario 'visiting the home page, not logged in' do

		visit '/'
		expect(page).to have_link "Jobhunting? Sign in!"

	end

	scenario 'clicking the sign in link stays in the same page' do
		visit '/'
		click_link "Job hunting? Sign in!"
		expect(current_path).to eq '/'
	end

	scenario 'clicking the sign in link lets you sign up', js: true do
		visit '/'
		click_link "Job hunting? Sign in!"
		click_link "Do not have an account? Sign up!"
		sleep 1
		expect(current_path).to eq '/'
		fill_in 'First name', with: 'Username'
		fill_in 'Email', with: 'test@test.com'
		fill_in 'Password', with: '12345678'
		fill_in 'Password confirmation', with: '12345678'
		click_button 'Sign up'
		expect(User.count).to eq 1
	end

	scenario 'during the sign up a photo can be added to the user profile' do
		visit '/'
		click_link "Job hunting? Sign in!"
		within("#user_login") do
			click_link "Do not have an account? Sign up!"
		end
		sleep 1
		expect(current_path).to eq '/'
		within('#user_signup') do
			fill_in 'First name', with: 'Username'
			fill_in 'Email', with: 'test@test.com'
			fill_in 'Password', with: '12345678'
			fill_in 'Password confirmation', with: '12345678'
			attach_file 'Profile picture', Rails.root.join('spec/images/user.jpg')
			click_button 'Sign up'
		end
		sleep 1
		click_link 'Edit registration'
		expect(page).to have_css 'img.uploaded-pic'
	end

	scenario "during the sign up a name can be added to the user profile" do
		visit '/'
		click_link "Job hunting? Sign in!"
		within("#user_login") do
			click_link "Do not have an account? Sign up!"
		end
		sleep 1
		expect(current_path).to eq '/'
		within('#user_signup') do
			fill_in 'First name', with: 'Bob'
			fill_in 'Last name', with: 'Geldof'
			fill_in 'Email', with: 'test@test.com'
			fill_in 'Password', with: '12345678'
			fill_in 'Password confirmation', with: '12345678'
			attach_file 'Profile picture', Rails.root.join('spec/images/user.jpg')
			click_button 'Sign up'
		end
		expect(page).to have_content 'Welcome, Bob'
	end

	scenario 'during the sign up a resume can be added to the user profile' do
		visit '/'
		click_link "Job hunting? Sign in!"
		within("#user_login") do
			click_link "Do not have an account? Sign up!"
		end
		sleep 1
		expect(current_path).to eq '/'
		within('#user_signup') do
			fill_in 'First name', with: 'Username'
			fill_in 'Email', with: 'test@test.com'
			fill_in 'Password', with: '12345678'
			fill_in 'Password confirmation', with: '12345678'
			attach_file 'CV', Rails.root.join('spec/files/resume.pdf')
			click_button 'Sign up'
		end
		click_link 'Edit registration'
		expect(page).to have_css 'img.uploaded-cv'
	end


	
end