require 'rails_helper'
require 'capybara/email/rspec'

describe 'email confirmation' do

	let(:job) {Job.create(advert_title: 'Test job name', category: 'Bar', company: 'Test company', full_time: 'true', detail: 'Detailed description', address: 'EC2', wage: 10, email: 'employer@test.com', phone: '12345678')}
	let(:user) {User.create name: 'Test', email: 'a@a.com', password: '12345678', password_confirmation: '12345678'}

	# scenario 'is sent when an order is created' do
	# 	clear_emails
	# 	Submission.create( job: job, user: user)
	# 	open_email('employer@test.com')
	# 	expect(current_email).to have_content 'You received an application'
	# 	expect(current_email.subject).to have_content 'You just received an application'
	# end

end
