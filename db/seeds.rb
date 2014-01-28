Group.create!([{name: "Star Wars"},{name: "BreatheHeavy"}] )

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
  {first_name: "Jar Jar",last_name: "Binks", email: "jarjar@binks.com", password:"password", phone: 6175158907, group_id: 1, admin: false }, 
  {first_name: "Holy",last_name: "Spearit", email: "holy@spearit.com", password:"password", phone: 6175158907, group_id: 2, admin: true },
  {first_name: "Godney",last_name: "Spears", email: "godney@spears.com", password:"password", phone: 6175158907, group_id: 2, admin: false },
  {first_name: "Jessica",last_name: "British", email: "jessica@british.com", password:"password", phone: 6175158907, group_id: 2, admin: false }
])



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

people = User.all.count-3



index = 1
while index<101 
  Task.create!({title: "Task number #{index}", groupid: 1, category: category_array.sample, duration: duration_array.sample, task_date: Time.now+rand(30).day, user_id: rand(people)+1})
  index += 1
end

while index<200
  Task.create!({title: "Task number #{index}", groupid: 1, category: category_array.sample, duration: duration_array.sample, task_date: Time.now-rand(30).day, user_id: rand(people)+1})
  index += 1
end

Task.all.each do |task|
  if task.id.to_i % 13 != 0
    assignee = rand(people)+1
    task.assignee_id = assignee == task.user_id ? rand(people)+1 : assignee
    task.save
  end
end


Task.create!([
  {title: "Task number 300", groupid: 2, category: category_array.sample, duration: duration_array.sample, task_date: Time.now-rand(30).day, user_id: 16, assignee_id: 17},
  {title: "Task number 301", groupid: 2, category: category_array.sample, duration: duration_array.sample, task_date: Time.now+rand(30).day, user_id: 16, assignee_id: 18},
  {title: "Task number 302", groupid: 2, category: category_array.sample, duration: duration_array.sample, task_date: Time.now+rand(30).day, user_id: 17, assignee_id: 18}
  ])




