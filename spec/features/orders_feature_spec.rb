require 'rails_helper'

describe 'orders page' do
	let(:admin) {Admin.create(email: 'tester@testicle.com', password: 'teste', password_confirmation: 'teste')}
end

context 'logged in as admin' do
	context 'no orders' do
		it 'sees a message' do
		visit '/orders'
		expect(page).to have_content 'No orders yet'
		end
	end
end
