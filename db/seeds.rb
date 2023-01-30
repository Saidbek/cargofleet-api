require 'faker'

# create vehicle
vehicle = Vehicle.create!(make: "Volvo", model: "XYR 12", manufacture_year: 5.years.from_now, color: "red", plate_number: "BC98731B", engine_number: "91918KGAK1823100", fuel_type: "diesel")

# create issues
issue = Issue.create!(vehicle: vehicle, title: "Chage oil", priority: "low")
issue = Issue.create!(vehicle: vehicle, title: "Replace brakes", priority: "low")

# create driver
driver = Driver.create!(first_name: "Mike", last_name: "Tyson", email: "mike@tyson.com", phone_number: "+11234522912")

