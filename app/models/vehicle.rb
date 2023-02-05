class Vehicle < ApplicationRecord
  acts_as_tenant :account

  enum fuel_type: [:diesel, :gasoline, :propane, :natural_gas]

  has_many :issues
  has_many :assignments
  has_one :driver, -> { where(active: true) }, class_name: 'Assignment'

  def as_json(options = {})
    super(AS_JSON_OPTS.merge(options))
  end

  AS_JSON_OPTS = {
    include: [:driver],
  }.freeze
end
