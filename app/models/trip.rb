class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :vehicle

  validates :driver, :vehicle, presence: true

  # methods
  def as_json(options = {})
    super(AS_JSON_OPTS.merge(options))
  end

  AS_JSON_OPTS = {
    only: [
      :id,
      :driver_id,
      :vehicle_id,
      :start_date,
      :end_date,
      :departure_location,
      :arrival_location,
      :distance,
      :duration,
      :completed
    ],
    include: [:driver, :vehicle]
  }.freeze
end
