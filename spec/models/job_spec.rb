require 'rails_helper'

RSpec.describe Job, :type => :model do

	context 'validating data for a new job' do
		it 'does not allow the creation of a job with no advert_title' do
			expect(Job.create category: 'Bar', company: 'Test company', full_time: 'true', detail: 'Detailed description', address: 'EC2', wage: 10).to have(2).errors_on(:advert_title)
			sleep 1
		end

		it 'does not allow the creation of a job with no company' do
			expect(Job.create advert_title: 'Test job advert_title', full_time: 'true', detail: 'Detailed description', address: 'EC2', wage: 10).to have(2).errors_on(:company)
			sleep 1
		end

		it 'does not allow the creation of a job with no address' do
			expect(Job.create advert_title: 'Test job advert_title', company: 'Test company', full_time: 'true', detail: 'Detailed description', wage: 10, email: 'example@test.com').to have(1).error_on(:address)
			sleep 1
		end

		it 'does not allow the creation of a job with a wage that is not an integer number' do
			expect(Job.create advert_title: 'Test job advert_title', company: 'Test company', full_time: 'true', detail: 'Detailed description', address: 'EC2', wage: 'test').to have(1).error_on(:wage)
		end

		it 'does not allow the creation of a job with an email that is not valid' do
			expect(Job.create advert_title: 'Test job advert_title', company: 'Test company', full_time: 'true', detail: 'Detailed description', address: 'EC2', wage: 'test', email: 'testwrongemail').to have(1).error_on(:email)
		end

		it 'does not allow the creation of a job with a advert_title that is more than 40 characters' do
			expect(Job.create advert_title: 'Very long advert_title, way more than 40 characters, not acceptable, sorry.', company: 'Test company', full_time: 'true', detail: 'Detailed description', address: 'EC2', wage: 'test', email: 'example@test.com').to have(1).error_on(:advert_title)
		end
		
	end
end
