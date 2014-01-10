# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



Group.create({name: 'Carwell_1'})

User.create({first_name: "brian", last_name: "Sisney", email: 'briansisny@gmail.com', phone: '6175158907', picture: 'picture', role: 'diva', admin: true, notes: "yep yep", group_id: Group.first.id})

User.create({first_name: "Tom", last_name: "Eric", email: 'tomeric@gmail.com', phone: '9999999', picture: 'picture', role: 'king', admin: true, notes: "hey hey", group_id: Group.first.id})      

Location.create({name: "Whole Foods", address: "543 Lamar", city: "Austin", state: "TX", zip: 78701})

Task.create({title: 'Whole Foods Shopping', category: 'Groceries', information: 'these are the list items', start_time: Time.now, duration: '2 hours', task_date: (Time.now + 24*60*60) , status: 'all good', user_id: User.first.id, assignee_id: User.last.id, location_id: Location.first.id })
Update.create({comment: "alls good", picture: "picture at Whole Foods", task_id: Task.first.id, user_id: User.last.id })


Like.create({user_id: User.first.id, update_id: Update.first.id})
      