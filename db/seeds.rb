require 'faker'

TEAMS = %w[team1 team2 team3 team4 team5].freeze

unless Account.any?
  TEAMS.each do |team_name|
    Account.create!(name: team_name)
  end
end

TEAMS.each do |team_name|
  ActsAsTenant.with_tenant(Account.find_by(name: team_name)) do
    unless Vehicle.any?
      # create vehicles
      40.times.map do
        brand = Faker::Vehicle.make
        vehicle_attrs = {
          brand: brand,
          model: Faker::Vehicle.model(make_of_model: brand),
          manufacture_year: Faker::Date.between(from: Date.today - 2.years, to: Date.today),
          color: Faker::Color.color_name,
          plate_number: Faker::Alphanumeric.alpha(number: 10).upcase,
          engine_number: Faker::Alphanumeric.alpha(number: 15),
          fuel_type: Vehicle.fuel_types.keys.sample,
          image_url: Faker::LoremFlickr.image,
          active: true
        }
        Vehicle.create!(vehicle_attrs)
      end
    end


    unless Issue.any?
      # create issues
      40.times.map do
        issue_attrs = {
          vehicle: Vehicle.all.sample,
          title: Faker::Lorem.sentence(word_count: 8),
          description: Faker::Lorem.sentence(word_count: 30),
          due_date: Faker::Date.between(from: 2.days.ago, to: Date.today),
          priority: Issue.priorities.keys.sample
        }
        Issue.create!(issue_attrs)
      end
    end

    unless Driver.any?
      # create driver
      40.times.map do
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

    unless Assignment.any?
      20.times.map do
        vehicle = Vehicle.all.sample
        unless vehicle.assignments.exists?(active: true)
          Assignment.create!(driver: Driver.all.sample,
                             vehicle: vehicle,
                             start_date: Faker::Date.between(from: Date.today - 2.years, to: Date.today),
                             start_odometer: Faker::Number.number(digits: 5),
                             start_comment: Faker::Lorem.sentence(10))
        end
      end
    end

  end
end

