require 'rails_helper'

describe 'primary map' do

	it 'displays the map on the homepage' do
		visit '/'
		expect(page).to have_css('#map')
	end

end