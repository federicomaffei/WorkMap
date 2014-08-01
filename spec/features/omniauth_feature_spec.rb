require 'rails_helper'

xdescribe 'Facebook Omniauth', js: true do 

	scenario 'user signs up via FB omniauth' do
		visit '/'
		click_link "Jobhunting? Sign in!"
		sleep 1
		click_link 'Sign in with Facebook'
		expect(page).to have_link "Search Filters"
	end

	scenario 'user signs up via FB omniauth' do
		visit '/'
		click_link "Jobhunting? Sign in!"
		sleep 1
		click_link 'Sign in with Google'
		expect(page).to have_field "Google"
	end
end