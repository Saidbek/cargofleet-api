class Driver < ApplicationRecord
  acts_as_tenant :account

  has_many :assignments
  has_one :vehicle, through: :assignments
end
