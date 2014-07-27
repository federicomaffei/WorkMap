require 'rails_helper'

describe 'user signing up' do 

	scenario 'visiting the home page, not logged in' do

		visit '/'
		expect(page).to have_link "Jobhunting? Sign in!"

	end

	scenario 'clicking the sign in link stays in the same page' do
		visit '/'
		click_link "Jobhunting? Sign in!"
		expect(current_path).to eq '/'
	end

	scenario 'clicking the sign in link lets you sign up', js: true do
		visit '/'
		click_link "Jobhunting? Sign in!"
		click_link "Do not have an account? Sign up!"
		sleep 1
		expect(current_path).to eq '/'
		fill_in 'Email', with: 'test@test.com'
		fill_in 'Password', with: '12345678'
		fill_in 'Password confirmation', with: '12345678'
		click_button 'Sign up'
		expect(User.count).to eq 1
	end
	
end