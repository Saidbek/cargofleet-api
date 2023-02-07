class Vehicle < ApplicationRecord
  acts_as_tenant :account

  enum fuel_type: [:diesel, :gasoline, :propane, :natural_gas]

  # associations
  has_many :issues
  has_many :assignments
  has_many :drivers, through: :assignments
  has_one :active_assignment, -> { where(active: true) }, class_name: 'Assignment'
  has_one :driver, through: :active_assignment

  # validations
  validates :brand,
            :model,
            :manufacture_year,
            :color,
            :plate_number,
            :engine_number,
            :fuel_type, presence: true

  def as_json(options = {})
    super(AS_JSON_OPTS.merge(options))
  end

  AS_JSON_OPTS = {
    only: [
      :id,
      :brand,
      :model,
      :manufacture_year,
      :color,
      :image_url,
      :plate_number,
      :engine_number,
      :fuel_type,
      :created_at,
      :updated_at,
      :active
    ],
    include: [:driver],
  }.freeze
end
