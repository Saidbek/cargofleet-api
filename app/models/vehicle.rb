class Vehicle < ApplicationRecord
  enum :fuel_type, [:diesel, :gasoline, :propane, :natural_gas]
end
