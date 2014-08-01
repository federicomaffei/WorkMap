require 'rails_helper'
require 'capybara/email/rspec'


describe 'employers job advert update page' do

	let(:employer) {Employer.create(email: 'test@test.net', password: '12345678', password_confirmation: '12345678')}

	specify 'employers can update jobs' do

		employer.jobs.create!(advert_title: 'Test job name', company: 'Test company', full_time: 'true', detail: 'Detailed description', address: 'EC2', wage: 5, email: 'email@test.com')
		login_as employer, scope: :employer
		visit "/employers/#{employer.id}/adverts"
		click_link 'Edit advert' 
		within '#employer_job_edit' do
			fill_in 'Advert title', with: 'Better name' 
			click_button('Update advert')
		end
		expect(page).to have_content 'Better name'

	end

	specify 'employers can remove jobs' do

		employer.jobs.create!(advert_title: 'Test job name', company: 'Test company', full_time: 'true', detail: 'Detailed description', address: 'EC2', wage: 5, email: 'email@test.com')
		login_as employer, scope: :employer

		visit "/employers/#{employer.id}/adverts"
		expect(Job.all.count).to eq 1
		click_link 'Remove advert'
		expect(page).not_to have_content("Test job name")
		expect(Job.all.count).to eq 0
	end

end