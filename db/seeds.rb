# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

3.times do |n|
  # user
  admin = false
  email = Faker::Internet.email
  if n == 0
    admin = true
    email = 'admin@example.com'
  end
  password = "password"
  name = email.match(/(.*)@/)[1]
  uid = User.create_unique_string  
  user = User.new email: email,
                  password: password,
                  password_confirmation: password,
                  name: name,
                  admin: admin,
                  uid: uid
  user.skip_confirmation!
  user.save!
end

# topic
User.all.each do |user|
  Topic.create! content: 'test' + user.id.to_s,
                user_id: user.id
end
