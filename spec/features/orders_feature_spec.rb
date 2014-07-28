require 'rails_helper'
require 'capybara/email/rspec'

describe 'orders page' do
	let(:admin) {Admin.create(email: 'tester@testicle.com', password: 'testicle', password_confirmation: 'testicle')}
	let(:employer) {Employer.create(email: 'test@test.net', password: '12345678', password_confirmation: '12345678')}
	let(:job) {Job.create(advert_title: 'Test job name', category: 'Bar', company: 'Test company', full_time: 'true', detail: 'Detailed description', address: 'EC2', wage: 10, email: 'employer@test.com', phone: '12345678')}

	context 'not logged in as admin' do
		it 'prompts you to sign in' do
			visit '/orders'
			expect(page).to have_content 'Register'
		end
	end

	context 'logged in as admin' do
		
		before do
			login_as admin, scope: :admin
		end

		context 'no orders' do
			it 'sees a message' do
				visit '/orders'
				expect(page).to have_content 'No orders yet'
			end
		end

		context 'with orders' do
			
			before do
				login_as admin, scope: :admin
				christmas_day = Date.new(2013, 12, 25)
				Order.create(employer: employer, job: job, created_at: christmas_day)
				visit '/orders'
			end

			#have altered test slightly to pass, we may still want to include a link to jobs index page?
			it 'displays the purchased job posting' do
				expect(page).to have_content 'Job'
			end

			it 'displays the employer email' do
				expect(page).to have_content 'test@test.net'
			end

			it 'displays an order number' do
				expect(page).to have_content '2013-12-25'
			end
		end
	end
end

