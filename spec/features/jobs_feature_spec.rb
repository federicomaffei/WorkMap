require 'rails_helper'

describe 'jobs index page' do
	context 'no jobs available yet.' do
		visit '/jobs'
		expect(page).to have_content 'No jobs inserted yet.'
	end
end