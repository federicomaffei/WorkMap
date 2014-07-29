require 'rails_helper'

describe 'employer signup email confirmation' do

	before do
		clear_emails
	end

	it 'is sent when an employer signs up' do
		Employer.create(email: 'test@test.net', password: '12345678', password_confirmation: '12345678')
		open_email('test@test.net')
		expect(current_email).to have_content 'Hi test@test.net,'
		expect(current_email.subject).to eq 'Thanks test@test.net for signing up'
	end

end