class Vehicle < ApplicationRecord
  enum fuel_type: [:diesel, :gasoline, :propane, :natural_gas]

  has_many :assignments
  has_one :driver, through: :assignments
end
