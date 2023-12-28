class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :vehicle

  validates :driver, :vehicle, presence: true
end
