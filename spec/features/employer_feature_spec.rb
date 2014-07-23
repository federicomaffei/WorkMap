require 'rails_helper'

describe 'employers job advert update page' do

	let(:employer) {Employer.create(email: 'test@test.net', password: '12345678', password_confirmation: '12345678')}

	specify 'employers can update jobs' do

		employer.jobs.create!(advert_title: 'Test job name', company: 'Test company', full_time: 'true', detail: 'Detailed description', address: 'EC2', wage: 5, email: 'email@test.com')
		login_as employer
		visit "/employers/#{employer.id}/adverts"
		click_link 'Edit advert' 
		fill_in 'Company', with: "Better company" 
		click_button('Update advert')
		expect(page).to have_content 'Better company' 

	end

	specify 'employers can remove jobs' do

		employer.jobs.create!(advert_title: 'Test job name', company: 'Test company', full_time: 'true', detail: 'Detailed description', address: 'EC2', wage: 5, email: 'email@test.com')
		login_as employer
		visit "/employers/#{employer.id}/adverts"
		expect(Job.all.count).to eq 1
		click_link 'Remove advert' 
		expect(page).not_to have_content("Test job name")
		expect(Job.all.count).to eq 0
	end

end