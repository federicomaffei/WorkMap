json.array! @jobs do |job|
	json.advert_title job.advert_title
	json.address job.address
	json.company job.company
	json.category job.category
	json.category_src "https://dl.dropboxusercontent.com/u/9315601/#{job.category}.png"
	json.latitude job.latitude
	json.longitude job.longitude
	json.detail job.detail
	json.email job.email
	json.phone job.phone
	json.wage job.wage
	json.hours (job.full_time? ? "Full time" : "Part time")
	json.max_distance @max_distance
	json.jobid job.id
end
