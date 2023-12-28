class Vehicle < ApplicationRecord
  acts_as_tenant :account

  enum fuel_type: [:diesel, :gasoline, :propane, :natural_gas]
  # scope :assigned_count, -> { left_joins(:trips).where(trips: { driver_id: nil }).count }
  # scope :unassigned_count, -> { left_joins(:trips).where.not(trips: { driver_id: nil }).count }
  scope :active_count, -> { where(active: true).count }
  scope :archived_count, -> { where(active: false).count }

  # associations
  has_many :issues, dependent: :destroy

  # validations
  validates :manufacture_year,
            :plate_number,
            :engine_number,
            :fuel_type, presence: true

  # methods

  def as_json(options = {})
    super(AS_JSON_OPTS.merge(options))
  end

  AS_JSON_OPTS = {
    only: [
      :id,
      :model,
      :manufacture_year,
      :image_url,
      :plate_number,
      :engine_number,
      :fuel_type,
      :created_at,
      :updated_at,
      :active
    ],
    include: [:issues]
  }.freeze
end
