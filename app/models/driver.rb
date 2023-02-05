class Driver < ApplicationRecord
  acts_as_tenant :account

  has_many :assignments
  has_many :vehicles, through: :assignments
  has_one :active_assignment, -> { where(active: true) }, class_name: 'Assignment'
  has_one :vehicle, through: :active_assignment

  def as_json(options = {})
    super(AS_JSON_OPTS.merge(options))
  end

  AS_JSON_OPTS = {
    only: [
      :first_name,
      :last_name,
      :birth_date,
      :email,
      :phone_number,
      :address1,
      :address2,
      :city,
      :state,
      :postal_code,
      :country,
      :license_number,
      :license_class,
      :license_state,
      :created_at,
      :updated_at
    ],
    include: [:vehicle]
  }.freeze
end
