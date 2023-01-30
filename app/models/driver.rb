class Driver < ApplicationRecord
  has_many :assignments
  has_one :vehicle, through: :assignments
end
