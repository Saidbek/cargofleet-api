require 'faker'

TEAMS = %w[team1 team2 team3 team4 team5].freeze

unless Account.any?
  TEAMS.each do |team_name|
    Account.create!(name: team_name)
  end
end

TEAMS.each do |team_name|
  freight_trucks = [
    ["Volvo VNL Series", "Volvo VNR Series", "Volvo FH Series"],
    ["Peterbilt 579", "Peterbilt 389", "Peterbilt 567"],
    ["Kenworth W900", "Kenworth T680", "Kenworth T880"],
    ["Freightliner Cascadia", "Freightliner Coronado", "Freightliner M2"],
    ["Mack Anthem", "Mack Pinnacle", "Mack Granite"],
    ["International LoneStar", "International LT Series", "International HV Series"],
    ["Western Star 4900", "Western Star 5700XE", "Western Star 4700"],
    ["Scania R Series", "Scania S Series", "Scania G Series"],
    ["MAN TGX", "MAN TGS", "MAN TGM"],
    ["Isuzu N-Series", "Isuzu F-Series", "Isuzu NPR"],
    ["Hino 195", "Hino 338", "Hino 268"],
    ["Freightliner MT55", "Freightliner MT45", "Freightliner S2"],
    ["GMC Sierra 2500HD", "GMC Sierra 3500HD", "GMC Savana"],
    ["Ram ProMaster", "Ram ProMaster City", "Ram 2500"],
    ["Ford Transit", "Ford Super Duty", "Ford F-650"],
    ["Chevrolet Silverado 2500HD", "Chevrolet Silverado 3500HD", "Chevrolet Express"],
    ["Nissan NV Cargo", "Nissan NV Passenger", "Nissan Titan XD"],
    ["Mercedes-Benz Actros", "Mercedes-Benz Arocs", "Mercedes-Benz Econic"],
    ["Iveco Stralis", "Iveco Eurocargo", "Iveco Daily"],
    ["DAF XF", "DAF CF", "DAF LF"],
    ["Volvo USA VHD", "Volvo USA VAH"],
    ["PACCAR Kenworth W990", "PACCAR Peterbilt 367"],
    ["Fuso Canter", "Fuso Fighter"],
    ["Oshkosh Striker", "Oshkosh M-ATV"],
    ["Freightliner Australia Argosy", "Freightliner Australia Coronado SD"],
    ["UD Quon", "UD Quester"],
    ["TATA Ultra", "TATA Signa"],
    ["Renault T", "Renault K"],
    ["FAW Jiefang J6", "FAW Jiefang J7"],
    ["Ashok Leyland Guru", "Ashok Leyland Captain"],
    ["Higer KLQ6109GQE", "Higer KLQ6129Q"]
  ]

  ActsAsTenant.with_tenant(Account.find_by(name: team_name)) do
    unless Vehicle.any?
      # create vehicles
      500.times.map do
        model = freight_trucks.sample.sample
        vehicle_attrs = {
          model: model,
          manufacture_year: Faker::Date.between(from: Date.today - 20.years, to: Date.today),
          plate_number: Faker::Alphanumeric.alpha(number: 8).upcase,
          engine_number: Faker::Alphanumeric.alphanumeric(number: 16, min_alpha: 1, min_numeric: 1).upcase,
          fuel_type: Vehicle.fuel_types.keys.sample,
          image_url: Faker::LoremFlickr.image(search_terms: ["truck"]),
          active: [false, true].sample
        }
        Vehicle.create!(vehicle_attrs)
      end
    end


    unless Issue.any?
      # create issues
      500.times.map do
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
      500.times.map do
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
          license_state: Faker::Address.state_abbr,
          active: [true, false].sample
        }
        Driver.create!(driver_attrs)
      end
    end

    unless Assignment.any?
      100.times.map do
        vehicle = Vehicle.all.sample
        unless vehicle.assignments.exists?(active: true)
          Assignment.create!(driver: Driver.all.sample,
                             vehicle: vehicle,
                             start_date: Faker::Date.between(from: Date.today - 2.years, to: Date.today),
                             start_odometer: Faker::Number.number(digits: 5),
                             start_comment: Faker::Lorem.sentence(word_count: 10))
        end
      end
    end

  end
end

