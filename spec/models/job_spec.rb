require 'rails_helper'

RSpec.describe Job, :type => :model do

	context 'validating data for a new job' do
		it 'does not allow the creation of a job with no name' do
			Job.create category: 'Bar', company: 'Test company', full_time: 'true', detail: 'Detailed description', location: 'EC2', pay: 10
			expect(Job.count).to eq 0
		end

		it 'does not allow the creation of a job with no company' do
			Job.create name: 'Test job name', full_time: 'true', detail: 'Detailed description', location: 'EC2', pay: 10
			expect(Job.count).to eq 0
		end

		it 'does not allow the creation of a job with no location' do
			Job.create name: 'Test job name', company: 'Test company', full_time: 'true', detail: 'Detailed description', pay: 10
			expect(Job.count).to eq 0
		end

		it 'does not allow the creation of a job with a pay that is not an integer number' do
			Job.create name: 'Test job name', company: 'Test company', full_time: 'true', detail: 'Detailed description', location: 'EC2', pay: 'test'
			expect(Job.count).to eq 0
		end

		it 'does not allow the creation of a job with an email that is not valid' do
			Job.create name: 'Test job name', company: 'Test company', full_time: 'true', detail: 'Detailed description', location: 'EC2', pay: 'test', email: 'testwrongemail'
			expect(Job.count).to eq 0
		end

		it 'does not allow the creation of a job with a name that is more than 40 characters' do
			Job.create name: 'Very long name, way more than 40 characters, not acceptable, sorry.', company: 'Test company', full_time: 'true', detail: 'Detailed description', location: 'EC2', pay: 'test', email: 'example@test.com'
			expect(Job.count).to eq 0
		end
	end
end
