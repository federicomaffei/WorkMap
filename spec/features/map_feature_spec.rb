require 'rails_helper'

describe 'primary map' do


	it 'displays the map on the homepage', js: true do
		# this test requires internet connection
		visit '/jobs'
		expect(page).to have_map
	end

	it 'displays a marker at an address given by an employer', js: true do
		job = Job.create advert_title: 'Waitress', category: 'Bar', company: 'Queen of Hoxton', full_time: 'false', detail: 'Detailed description', address: 'EC2A 3JX', wage: 10, email: 'queen@hoxton-test.com', phone: '12345678'
		visit '/jobs'
		sleep 1
		expect(page.evaluate_script("window.map.markers.length")).to eq 1
	end

	context 'jobs by locations' do

		xit 
			job = Job.create advert_title: 'Waitress', category: 'Bar', company: 'Queen of Hoxton', full_time: 'false', detail: 'Detailed description', address: 'EC2A 3JX', wage: 10, email: 'queen@hoxton-test.com', phone: '12345678'
		end		

end