require 'rails_helper'

feature 'jobs index page' do
	scenario 'no jobs available yet.' do
		visit '/jobs'
		expect(page).to have_content 'No jobs inserted yet.'
	end
end