class AdvertsController < ApplicationController

def index
	@employer = current_employer
	@adverts = @employer.jobs
end

end
