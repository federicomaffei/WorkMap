require 'rails_helper'
	
	
describe 'job cancellation' do
	before do
		clear_emails
	end

let(:employer) {Employer.create(email: 'test@test.net', password: '12345678', password_confirmation: '12345678')}

	it 'when employer removes a job is removed a confirmation email is sent' do
		employer.jobs.create!(advert_title: 'Test job name', company: 'Test company', full_time: 'true', detail: 'Detailed description', address: 'EC2', wage: 5, email: 'email@test.com')
		login_as employer, scope: :employer
		visit "/employers/#{employer.id}/adverts"
		click_link 'Remove advert'

		open_email('test@test.net')
		expect(current_email).to have_content "Sorry that you cancelled your advert"
	end
end
