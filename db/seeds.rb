# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Job.delete_all

def postcode_back_stub
	# [*1..9].sample.to_s 
	# [*1..9].sample.to_s + [*'A'..'Z'].sample 
	[*1..9].sample.to_s + ([*'A'..'Z'].sample + [*'A'..'Z'].sample)
end

def front_stub_array
	front_stubs = []
	postcodes = [['E',20],['N',22],['NW',11],['SW',20],['SE',28],['W',14]]
	postcodes.each do |postcode|
		front_stubs << [*1..postcode[1]].fill(postcode[0]).zip(1..postcode[1]).map(&:join)
	end
	return front_stubs
end

def gen_postcodes
	addresses = []
	front_stub_array.flatten.each do |front_stub|
		addresses << (front_stub + ' ' + postcode_back_stub)
	end
	return addresses
end

def gen_category
	# ['Bar', 'Hotel', 'Cafe', 'Restaurant', 'Shop', 'StripClub'].sample
	['Bar', 'Hotel', 'Cafe', 'Restaurant', 'Shop', 'Strip Club'].sample
end



@employer = Employer.create(email: 'test@test.net', password: '12345678', password_confirmation: '12345678')
gen_postcodes.each_with_index do |address, index|
	job = Job.new advert_title: "Test job name #{index}", category: "#{gen_category}", company: "Test company #{index}", full_time: [true, false].sample, detail: 'Detailed description', address: "#{address}, London", wage: 10, email: 'employer@test.com', phone: '12345678'
	job.employer = @employer
	job.save
	sleep 0.25
end





# Job.create advert_title: 'Test job name 1', category: 'Bar', company: 'Test company', full_time: 'true', detail: 'Detailed description', address: '25 City Road, London', wage: 10, email: 'employer@test.com', phone: '12345678'
# Job.create advert_title: 'Test job name 2', category: 'Shop', company: 'Test company', full_time: 'true', detail: 'Detailed description', address: 'SW6 1RE, London', wage: 12, email: 'employer@test.com', phone: '12345678'
# Job.create advert_title: 'Test job name 3', category: 'Resturant', company: 'Test company', full_time: 'true', detail: 'Detailed description', address: '6 Freegrove Road, London', wage: 15, email: 'employer@test.com', phone: '12345678'
# Job.create advert_title: 'Test job name 4', category: 'Strip Club', company: 'Test company', full_time: 'true', detail: 'Detailed description', address: 'Wembley Stadium, London', wage: 8, email: 'employer@test.com', phone: '12345678'
# Job.create advert_title: 'Test job name 5', category: 'Cafe', company: 'Test company', full_time: 'true', detail: 'Detailed description', address: 'The Shard, London', wage: 20, email: 'employer@test.com', phone: '12345678'
# Job.create advert_title: 'Test job name 6', category: 'Bar', company: 'Test company', full_time: 'true', detail: 'Detailed description', address: 'Brixton, London', wage: 12, email: 'employer@test.com', phone: '12345678'
# Job.create advert_title: 'Test job name 7', category: 'Hotel', company: 'Test company', full_time: 'true', detail: 'Detailed description', address: 'Canary Wharf, London', wage: 10, email: 'employer@test.com', phone: '12345678'
# sleep 2


