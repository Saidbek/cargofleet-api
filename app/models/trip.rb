class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :vehicle

  validates :driver, :vehicle, presence: true

  scope :completed_count, -> { where(completed: true).count }
  scope :ongoing_count, -> { where(completed: false).count }
  scope :last_30_days_count, -> { where('start_date >= ?', 30.days.ago).count }

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
