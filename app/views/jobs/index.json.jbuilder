json.array! @jobs do |job|
	json.advert_title job.advert_title
	json.address job.address
	json.category job.category
	json.latitude job.latitude
	json.longitude job.longitude
end

json.jobs = @jobs