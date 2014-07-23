require 'rails_helper'

describe 'orders page' do
	let(:admin) {Admin.create(email: 'tester@testicle.com', password: 'teste', password_confirmation: 'teste')}

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
	end

	context 'not logged in as admin' do
		it 'prompts you to sign in' do
			visit '/orders'
			expect(page).to have_content 'sign up'
		end
	end

end