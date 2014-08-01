require 'rails_helper'


describe 'visiting the landing page' do 

		specify 'when not logged in lets you find or create a job' do 
			visit '/landing_page'
			expect(page).to have_link 'Hiring? Post a job!'  
			expect(page).to have_field 'Find a job in...'
		end

	context 'as a employer looking to post a job', js: true do 

		specify 'clicking the "create a job" link prompts you to sign in' do 
			visit '/landing_page'
			click_link 'Hiring? Post a job!'
			expect(current_path).to eq '/landing_page'
			expect(page).to have_content 'Sign in'  
		end

	end

	context 'as a job seeker looking to find a job', js: true do 

		specify 'searching takes you to the jobs map page' do 
			visit '/landing_page'
			fill_in 'Find a job in...', with: "London"
			page.execute_script("$('#landing_page_search_box').submit()")
			expect(page).to have_content 'Minimum Pay'
		end

	end


end