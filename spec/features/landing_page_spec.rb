require 'rails_helper'


describe 'visiting the landing page' do 

		it 'as either an employer or job seeker' do 
			visit '/landing_page'
			expect(page).to have_content 'Post a job'  
			expect(page).to have_content 'Find a job'
		end

	# context 'as a employer looking to post jobs' do 

	# 	it 'and clicking the post a job link' do 
	# 		visit '/landing_page'
	# 		expect(page).to have_context  

	# 	end

	# context 'as a job seeker looking to post jobs' do 

	# 	it 'and clicking the find a job link' do 
	# 		visit '/landing_page'
	# 		expect(page).to have_context 

	# 	end


end