Group.create!({name: "Star Wars"})

User.create!([
  {first_name: "Luke",last_name: "Skywalker", email: "luke@skywalker.com", password:"password", phone: 6175158907, group_id: 1, admin: true },
  {first_name: "rtwo",last_name: "dtwo", email: "rtwo@dtwo.com", password:"password", phone: 6175158907, group_id: 1, admin: false },
  {first_name: "Princess",last_name: "Leia", email: "princess@leia.com", password:"password", phone: 6175158907, group_id: 1, admin: false },
  {first_name: "Anakin",last_name: "Skywalker", email: "Anakin@Skywalker.com", password:"password", phone: 6175158907, group_id: 1, admin: false },
  {first_name: "cthree",last_name: "po", email: "cthree3@po.com", password:"password", phone: 6175158907, group_id: 1, admin: false },
  {first_name: "Yoda",last_name: "jedi", email: "yoda@jedi.com", password:"password", phone: 6175158907, group_id: 1, admin: false },
  {first_name: "Han",last_name: "Solo", email: "han@solo.com", password:"password", phone: 6175158907, group_id: 1, admin: false },
  {first_name: "Jabba",last_name: "Hut", email: "jabba@hut.com", password:"password", phone: 6175158907, group_id: 1, admin: false },
  {first_name: "Chewy",last_name: "baca", email: "chewy@baca.com", password:"password", phone: 6175158907, group_id: 1, admin: false },
  {first_name: "Obi",last_name: "Wan", email: "obei@wan.com", password:"password", phone: 6175158907, group_id: 1, admin: false },
  {first_name: "Darth",last_name: "Vader", email: "darth@vader.com", password:"password", phone: 6175158907, group_id: 1, admin: false },
  {first_name: "Sith",last_name: "Lord", email: "sith@lord.com", password:"password", phone: 6175158907, group_id: 1, admin: false },
  {first_name: "Boba",last_name: "Fett", email: "boba@fett.com", password:"password", phone: 6175158907, group_id: 1, admin: false },
  {first_name: "Padme",last_name: "Amidala", email: "padme@amidala.com", password:"password", phone: 6175158907, group_id: 1, admin: false },
  {first_name: "Jar Jar",last_name: "Binks", email: "jarjar@binks.com", password:"password", phone: 6175158907, group_id: 1, admin: false }
])
index = 1
while index<101
  Task.create!({title: "Task number #{index}"})
  index += 1
end


category_array = [
"getting places",
 "around the home",
 "shopping",
 "meals",
 "personal care",
 "odds & ends",
 "visits & outings",
 "remote"
]

duration_array = [15,  30,  45,  60,  75, 90, 120]

task_date_array = [
Time.now+1.day,
Time.now-1.day,
Time.now+3.day,
Time.now-3.day,
Time.now+7.day,
Time.now-7.day,
Time.now+rand(30).day,
Time.now-rand(30).day,
Time.now+rand(30).day,
Time.now-rand(30).day
]

people = User.all.count


Task.all.each do |task|
  task.category = category_array.sample
  task.duration = duration_array.sample
  task.task_date = task_date_array.sample
  user = rand(people)+1
  task.user_id = user
  assignee = rand(people)+1
  task.assignee_id = assignee == user ? rand(people)+1 : assignee
  task.groupid = 1
  task.save
end




