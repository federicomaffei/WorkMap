require 'rails_helper'


describe 'visiting the landing page' do 

		it 'as either an employer or job seeker' do 
			visit '/landing_page'
			expect(page).to have_content 'Post a job'  
			expect(page).to have_button 'Find a job'
		end

	context 'as a employer looking to post a job', js: true do 

		specify 'clicking the "post a job" link prompts you to sign in' do 
			visit '/landing_page'
			execute_script("$('.btn-large').click()")
			expect(current_path).to eq '/landing_page'
			expect(page).to have_content 'Sign in'  
		end

	end

	context 'as a job seeker looking to find a job', js: true do 

		it 'searching takes you to the jobs map page' do 
			visit '/landing_page'
			fill_in 'Find a job in...', with: "London"
			page.execute_script("$('#landing_page_search_box').submit()")
			sleep 1
			# expect(page).to have_content 'Find a job in London'
			expect(current_path).to eq '/jobs'
		end

	end


end