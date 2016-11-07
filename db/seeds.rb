# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Activity.destroy_all
Property.destroy_all

admin = User.create(username: 'admin', password: 'admin', account_type: 'admin', token: 'admin_token')
agent1 = User.create(username: 'agent1', password: 'agent1', account_type: 'agent', token: 'agent1_token')
agent2 = User.create(username: 'agent2', password: 'agent2', account_type: 'agent', token: 'agent2_token')
customer1 = User.create(username: 'customer1', password: 'customer1', account_type: 'customer', token: 'customer1_token')
customer2 = User.create(username: 'customer2', password: 'customer2', account_type: 'customer', token: 'customer2_token')

Activity.create(event:'User created: admin', date: 12.days.ago, user: admin)
Activity.create(event:'User created: agent1', date: 10.days.ago, user: agent1)
Activity.create(event:'Property created: agent1', date: 9.days.ago, user: agent1)
Activity.create(event:'User created: customer1', date: 5.days.ago, user: customer1)
Activity.create(event:'Property rented: Stack Apt', date: 4.days.ago, user: customer1)
Activity.create(event:'User created: agent2', date: 2.days.ago, user: agent2)
Activity.create(event:'Property created: Levi Stadium', date: 1.days.ago, user: agent2)
Activity.create(event:'User logged out: customer1', date: 10.minutes.ago, user: agent1)
Activity.create(event:'User created: customer2', date: 5.minutes.ago, user: customer2)
Activity.create(event:'Property sold: customer2', date: 1.minutes.ago, user: customer2)

Property.create!(name: 'US Post Office', street: '105 North 1st Street',
  city: 'San Jose', state: 'CA', latitude: 37.337775, longitude: -121.892338,
  status: 'for sale', agent: agent1)

Property.create(name: 'San Pedro Square Market', street: '87 N San Pedro St',
  city: 'San Jose', state: 'CA', latitude: 37.336444, longitude: -121.894301,
  status: 'for sale', agent: agent1)

Property.create(name: 'SAP Center', street: '255 S Almaden Blvd',
  city: 'San Jose', state: 'CA', latitude: 37.332557, longitude: -121.901137,
  status: 'for rent', agent: agent1)

Property.create(name: 'AFK Gamer Lounge', street: '163 W Santa Clara St',
  city: 'San Jose', state: 'CA', latitude: 37.335179, longitude: -121.893526,
  status: 'for rent', agent: agent2)

Property.create(name: 'San Jose Convention Center', street: '150 W San Carlos St',
  city: 'San Jose', state: 'CA', latitude: 37.328852, longitude: -121.890586,
  status: 'sold', agent: agent1, resident: customer1)

Property.create(name: 'San Jose Musuem of Art', street: '110 S Market St',
  city: 'San Jose', state: 'CA', latitude: 37.333877, longitude: -121.890006,
  status: 'rented', agent: agent2, resident: customer2)

Property.create(name: 'The Tech Musuem of Innovation', street: '201 S Market St',
  city: 'San Jose', state: 'CA', latitude: 37.331864, longitude: -121.888709,
  status: 'for sale', agent: agent2)
