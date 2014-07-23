# any ruby file in 'support' directory is automatically loaded into our tests

class Capybara::Session

	def has_map?
		has_css?('.gm-style')
	end

end
