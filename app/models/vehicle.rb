class Vehicle < ApplicationRecord
  acts_as_tenant :account

  enum fuel_type: [:diesel, :gasoline, :propane, :natural_gas]
  scope :assigned_count, -> { left_joins(:trips).where(trips: { driver_id: nil }).count }
  scope :unassigned_count, -> { left_joins(:trips).where.not(trips: { driver_id: nil }).count }
  scope :active_count, -> { where(active: true).count }
  scope :archived_count, -> { where(active: false).count }

  # associations
  has_many :issues, dependent: :destroy
  has_many :trips, dependent: :destroy
  has_many :drivers, through: :trips
  has_one :active_trip, -> { where(active: true) }, class_name: 'Trip'
  has_one :driver, through: :active_trip

  # validations
  validates :manufacture_year,
            :plate_number,
            :engine_number,
            :fuel_type, presence: true

  # methods
  def self.cached_assigned_count
    # Rails.cache.fetch(Vehicle.last, expires_in: 1.minute) do
      Vehicle.assigned_count
    # end
  end

  def self.cached_unassigned_count
    # Rails.cache.fetch(Vehicle.last, expires_in: 1.minute) do
      Vehicle.unassigned_count
    # end
  end

  def self.cached_active_count
    # Rails.cache.fetch(Vehicle.last, expires_in: 1.minute) do
      Vehicle.active_count
    # end
  end

  def self.cached_archived_count
    # Rails.cache.fetch(Vehicle.last, expires_in: 1.minute) do
      Vehicle.archived_count
    # end
  end


  def as_json(options = {})
    super(AS_JSON_OPTS.merge(options))
  end

  AS_JSON_OPTS = {
    only: [
      :id,
      :manufacture_year,
      :image_url,
      :plate_number,
      :engine_number,
      :fuel_type,
      :created_at,
      :updated_at,
      :active
    ],
    include: [:driver, :active_trip],
  }.freeze
end
