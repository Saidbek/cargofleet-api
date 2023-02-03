require 'faker'

unless Vehicle.any?
  # create vehicles
  80.times.map do
    brand = Faker::Vehicle.make
    vehicle_attrs = {
      make: brand,
      model: Faker::Vehicle.model(make_of_model: brand),
      manufacture_year: Faker::Date.between(from: Date.today - 2.years, to: Date.today),
      color: Faker::Color.color_name,
      plate_number: Faker::Alphanumeric.alpha(number: 10).upcase,
      engine_number: Faker::Alphanumeric.alpha(number: 15),
      fuel_type: Vehicle.fuel_types.keys.sample,
      image: Faker::Placeholdit.image(size: '100x100', format: 'jpg')
    }
    Vehicle.create!(vehicle_attrs)
  end
end


unless Issue.any?
  # create issues
  80.times.map do
    issue_attrs = {
      vehicle: Vehicle.all.sample,
      title: Faker::Lorem.sentence(word_count: 8),
      description: Faker::Lorem.sentence(word_count: 30),
      reported_at: Faker::Date.between(from: 2.days.ago, to: Date.today),
      priority: Issue.priorities.keys.sample
    }
    Issue.create!(issue_attrs)
  end
end

unless Driver.any?
  # create driver
  80.times.map do
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    driver_attrs = {
      first_name: first_name,
      last_name: last_name,
      birth_date: Faker::Date.between(from: Date.today - 50.years, to: Date.today - 18.years),
      email: "#{first_name}.#{last_name}@gmail.com",
      phone_number: Faker::PhoneNumber.cell_phone,
      address1: Faker::Address.street_address,
      city: Faker::Address.city,
      state: Faker::Address.state,
      postal_code: Faker::Address.zip_code,
      country: Faker::Address.country,
      license_number: Faker::Alphanumeric.alpha(number: 10).upcase,
      license_class: Faker::Alphanumeric.alpha(number: 1).upcase,
      license_state: Faker::Address.state_abbr
    }
    Driver.create!(driver_attrs)
  end
end

