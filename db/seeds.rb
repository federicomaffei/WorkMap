# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Job.delete_all

# def postcode_back_stub
# 	# [*1..9].sample.to_s 
# 	# [*1..9].sample.to_s + [*'A'..'Z'].sample 
# 	[*1..9].sample.to_s + ([*'A'..'Z'].sample + [*'A'..'Z'].sample)
# end

# def front_stub_array
# 	front_stubs = []
# 	postcodes = [['E',20],['N',22],['NW',11],['SW',20],['SE',28],['W',14]]
# 	postcodes.each do |postcode|
# 		front_stubs << [*1..postcode[1]].fill(postcode[0]).zip(1..postcode[1]).map(&:join)
# 	end
# 	return front_stubs
# end

# def gen_postcodes
# 	addresses = []
# 	front_stub_array.flatten.each do |front_stub|
# 		addresses << (front_stub + ' ' + postcode_back_stub)
# 	end
# 	return addresses
# end

def gen_category
	['Bar', 'Pub', 'Hotel', 'Cafe', 'Restaurant', 'Retail'].sample
end


# gen_postcodes.each_with_index do |address, index|
# 	job = Job.new advert_title: "Test job name #{index}", category: "#{gen_category}", company: "Test company #{index}", full_time: [true, false].sample, detail: 'Detailed description', address: "#{address}, London", wage: [*5..20].sample, email: 'employer@test.com', phone: '12345678'
# 	job.employer = @employer
# 	job.save
# 	sleep 1
# end


@employer = Employer.create(email: 'test@test.net', password: '12345678', password_confirmation: '12345678')

1000.times do
	# job = Job.new latitude: (latitude_start + random_lat_add), longitude: (-0.602875 + random_long_add), advert_title: "Test job name index", category: "#{gen_category}", company: "Test company index", full_time: [true, false].sample, detail: 'Detailed description', address: "(address) London", wage: [*5..20].sample, email: 'employer@test.com', phone: '12345678'
	detail_descrip = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas condimentum rhoncus scelerisque. Ut vel urna turpis. Phasellus gravida malesuada enim quis mattis.Aenean vestibulum, lectus at vestibulum tempus, purus diam euismod nisi, ut volutpat nisi massa sit amet mauris.'
	job = Job.new latitude: (51.2902111 + (0.37/100)*rand(101)), longitude: (-0.505371 + (0.68/100)*rand(101)), advert_title: "Test job name", category: "#{gen_category}", company: "Test company", full_time: [true, false].sample, detail: detail_descrip, address: "Address, London", wage: [*5..20].sample, email: 'employer@test.com', phone: '012345678'
	job.employer = @employer
	job.save
end

# 51.290211, 0.175781
# 51.656318, -0.505371




