Group.create!([{name: "Hook"},{name: "BreatheHeavy"}] )

User.create!([
  {first_name: "Captain",last_name: "Hook", email: "captain@hook.com", password:"password", phone: 6175158907, group_id: 1, admin: true },
  {first_name: "Tinker",last_name: "Bell", email: "tinker@bell.com", password:"password", phone: 6175158907, group_id: 1, admin: false },
  {first_name: "Tiger",last_name: "Lily", email: "tiger@lily.com", password:"password", phone: 6175158907, group_id: 1, admin: false },
  {first_name: "Lost",last_name: "Boys", email: "lost@boys.com", password:"password", phone: 6175158907, group_id: 1, admin: false },
  {first_name: "Peter",last_name: "Pan", email: "peter@pan.com", password:"password", phone: 6175158907, group_id: 1, admin: false },
  {first_name: "Mr",last_name: "Smee", email: "mr@smee.com", password:"password", phone: 6175158907, group_id: 1, admin: false },
  {first_name: "Holy",last_name: "Spearit", email: "holy@spearit.com", password:"password", phone: 6175158907, group_id: 2, admin: true },
  {first_name: "Godney",last_name: "Spears", email: "godney@spears.com", password:"password", phone: 6175158907, group_id: 2, admin: false },
  {first_name: "Jessica",last_name: "British", email: "jessica@british.com", password:"password", phone: 6175158907, group_id: 2, admin: false }
])

User.create(first_name: "Aldie",last_name: "Boggs", email: "aldiejboggs@gmail.com", password:"password", phone: 6174486590, group_id: 3, admin: true)
User.create(first_name: "Dave",last_name: "Boggs", email: "dboggs@syberworks.com", password:"password", phone: 7812546159, group_id: 3, admin: true)


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

duration_array = [15,  30,  45,  60, 75, 90, 120]

people = User.all.count-3



index = 1
while index<12
  Task.create!({title: "Task number #{index}", groupid: 1, category: category_array.sample, duration: duration_array.sample, task_date: Time.now-rand(30).day, user_id: rand(people)+1})
  index += 1
end

while index<27
  Task.create!({title: "Task number #{index}", groupid: 1, category: category_array.sample, duration: duration_array.sample, task_date: Time.now+rand(30).day, user_id: rand(people)+1})
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




