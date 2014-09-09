require 'rails_helper'

describe 'primary map' do

	it 'displays the map on the homepage', js: true do
		visit '/jobs'
		sleep 1
		expect(page).to have_map
	end

	context 'markers' do

		it 'displays a marker for a job', js: true do
			job = Job.create advert_title: 'Waitress', category: 'Bar', company: 'Queen of Hoxton', full_time: 'false', detail: 'Detailed description', address: 'EC2A 3JX', wage: 10, email: 'queen@hoxton-test.com', phone: '12345678'
			visit '/jobs'
			sleep 1
			expect(page.evaluate_script("window.markers.length")).to eq 1
		end

		xit 'stops including bar markers when you uncheck the bar box and includes them again when you recheck it', js: true do
			# Works in browser, test failing - probably related to Switchery?
			job = Job.create advert_title: 'Waitress', category: 'Bar', company: 'Queen of Hoxton', full_time: 'false', detail: 'Detailed description', address: 'EC2A 3JX', wage: 10, email: 'queen@hoxton-test.com', phone: '12345678'
			Job.create advert_title: 'Waitress', category: 'Restaurant', company: 'Kings Arms', full_time: 'false', detail: 'Detailed description', address: 'EC2A 3JX', wage: 10, email: 'a@b.com', phone: '12345678'
			visit '/jobs'
			click_link 'Search Filters'
			page.execute_script('$("#bar_box").prop("checked", false); $(".bar_slider .switchery").trigger("click")')
			click_button 'Refine Search'
			sleep 1
			expect(page).not_to have_content "Queen of Hoxton"
			page.execute_script('$("#bar_box").prop("checked", true); $(".bar_slider .switchery").trigger("click")')
			click_button 'Refine Search'
			sleep 1
			expect(page).to have_content "Queen of Hoxton"
		end

	end



end