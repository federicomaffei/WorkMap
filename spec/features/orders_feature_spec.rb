require 'rails_helper'

describe 'orders page' do
	let(:admin) {Admin.create(email: 'tester@testicle.com', password: 'testicle', password_confirmation: 'testicle')}
	let(:employer) {Employer.create(email: 'test@test.net', password: '12345678', password_confirmation: '12345678')}

	context 'not logged in as admin' do
		it 'prompts you to sign in' do
			visit '/orders'
			expect(page).to have_content 'sign up'
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

				Order.create(id: 1, employer: employer, created_at: christmas_day)
				visit '/orders'
			end

			it 'displays the purchased job posting' do
				expect(page).to have_link 'Job 1'
			end

			it 'displays the employer email' do
				expect(page).to have_content 'test@test.com'
			end

			it 'displays an order number' do
				expect(page).to have_content '25121301'
			end
		end
	end

end