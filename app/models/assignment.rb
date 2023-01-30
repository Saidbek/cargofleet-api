class Assignment < ApplicationRecord
  belongs_to :driver
  belongs_to :vehicle

  validates :start_date, :start_odometer, :driver, :vehicle, presence: true
  validates :end_odometer, numericality: { greater_than_or_equal_to: :start_odometer }, if: :end_odometer
  validates :end_date, date: { after: :start_date }, date: { after: Date.today }, if: :end_date
end
