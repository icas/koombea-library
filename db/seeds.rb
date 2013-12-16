# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Role.create(role: 'user')
Role.create(role: 'admin')
Role.create(role: 'root')

User.create(email: "ricardo.berdejo@koombea.com", role_id: 3)
User.create(email: "erlinis.quintana@koombea.com", role_id: 2)
User.create(email: "ivan.ardila@koombea.com", role_id: 1)