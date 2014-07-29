require 'rails_helper'

describe 'order email confirmation' do

	before do
		clear_emails
	end

	let(:employer) {Employer.create(email: 'test@test.net', password: '12345678', password_confirmation: '12345678')}
	let(:job) {Job.create(advert_title: 'Test job name', category: 'Bar', company: 'Test company', full_time: 'true', detail: 'Detailed description', address: 'EC2', wage: 10, email: 'jobs@test.net', phone: '12345678')}


	it 'is sent when an order is created' do
		Order.create(job: job, employer: employer)
		open_email('test@test.net')
		expect(current_email).to have_content 'Thanks for placing your advert'
		expect(current_email.subject).to eq "'Test job name' placement confirmed"
	end

end