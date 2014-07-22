require 'rails_helper'

RSpec.describe Employer, :type => :model do

	let(:employer) {Employer.create(email: 'test@test.net', password: '12345678', password_confirmation: '12345678')}

	context 'employers postings jobs' do 
	
		it 'employers can create jobs' do 
			employer.jobs.create!(advert_title: 'Test job name', company: 'Test company', full_time: 'true', detail: 'Detailed description', address: 'EC2', wage: 5, email: 'email@test.com')
			expect(employer.jobs.count).to eq 1
		end

	end


  
end
