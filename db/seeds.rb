# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Group.create({name: 'Our MakerSquare Family'})

User.create({first_name: "Brian", last_name: "Sisney", email: 'user1@gmail.com', phone: '6175158907', picture: "http://i.imgur.com/mUqbaSL.jpg", role: 'CTO', admin: true, notes: "This is Brian. He's a nice guy.", group_id: Group.first.id, password: 'password', password_confirmation: 'password'})

User.create({first_name: "Eric", last_name: "Boggs", email: 'user2@gmail.com', phone: '5555555555', picture: "http://i.imgur.com/hy12swF.jpg", role: 'CEO', admin: true, notes: "This is Eric. He came up with the idea for CareWell. How thoughtful.", group_id: Group.first.id, password: 'password', password_confirmation: 'password'})

User.create({first_name: "Tom", last_name: "Hanlon", email: 'user3@gmail.com', phone: '5555555555', picture: "http://i.imgur.com/J5Eyd7H.jpg", role: 'Janitor', admin: true, notes: "This is Tom. He keeps this place nice and tidy.", group_id: Group.first.id, password: 'password', password_confirmation: 'password'})      

Location.create({name: "Whole Foods", address: "543 Lamar", city: "Austin", state: "TX", zip: 78701})

Task.create({title: 'Grocery shopping', category: 'shopping', information: 'Be sure to pick up milk and bread!', duration: '1 hour' , status: 'Pending', task_date: Time.now, user_id: User.first.id, assignee_id: User.last.id, location_id: Location.first.id })

Update.create({comment: "I love the candy aisle", picture: "http://i.imgur.com/hJmAlVY.jpg", task_id: Task.first.id, user_id: 1 })

Update.create({comment: "Take Grandma to the salad bar.", picture: "http://i.imgur.com/gKkgw3K.jpg", task_id: Task.first.id, user_id: 2 })

Update.create({comment: "Don't forget the bread.", picture: "http://i.imgur.com/Ab6HzQh.jpg", task_id: Task.first.id, user_id: 3 })

Like.create({user_id: User.first.id, update_id: Update.first.id})
      