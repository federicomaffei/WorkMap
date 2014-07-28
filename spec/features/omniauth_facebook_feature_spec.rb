require 'rails_helper'

describe 'user signing up via Facebook', js: true do 

	visit '/'
	click_link "Jobhunting? Sign in!"
	click_link "Do not have an account? Sign up!"
	sleep 1
	expect(current_path).to eq '/'
	
end