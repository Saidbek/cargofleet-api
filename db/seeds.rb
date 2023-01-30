# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# create vehicle
vehicle = Vehicle.create!(make: "Volvo", model: "XYR 12", manufacture_year: 5.years.from_now, color: "red", plate_number: "BC98731B", engine_number: "91918KGAK1823100", fuel_type: "diesel")

# create issues
issue = Issue.create!(vehicle: vehicle, title: "Chage oil", priority: "low")
issue = Issue.create!(vehicle: vehicle, title: "Replace brakes", priority: "low")

# create driver
driver = Driver.create!(first_name: "Mike", last_name: "Tyson", email: "mike@tyson.com", phone_number: "+11234522912")

