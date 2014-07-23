require 'rails_helper'


describe 'visiting the landing page' do 

		it 'as either an employer or job seeker' do 
			visit '/landing_page'
			expect(page).to have_content 'Post a job'  
			expect(page).to have_content 'Find a job'
		end

	context 'as a employer looking to post a job' do 

		it 'and clicking the post a job link' do 
			visit '/landing_page'
			click_link 'Post a job'
			expect(current_path).to eq '/employers/sign_in'
			expect(page).to have_content 'Sign in'  
		end

	end

	context 'as a job seeker looking to find a job' do 

		it 'and clicking the find a job link' do 
			visit '/landing_page'
			click_link 'Find a job'
			# expect(page).to have_content 'Find a job in London'
			# expect(current_path).to eq '/jobs/index'
		end

	end


end