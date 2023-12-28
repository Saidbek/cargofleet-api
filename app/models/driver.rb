class Driver < ApplicationRecord
  acts_as_tenant :account

  # associations
  has_many :trips, dependent: :destroy
  has_many :vehicles, through: :trips, dependent: :destroy

  # validations
  validates :first_name,
            :last_name,
            :birth_date,
            :email,
            :address1,
            :city,
            :state,
            :postal_code,
            :license_number,
            :account_id, presence: true

  # methods

  def self.cached_archived_count
    # Rails.cache.fetch(Driver.last, expires_in: 1.minute) do
      Driver.archived_count
    # end
  end

  def as_json(options = {})
    super(AS_JSON_OPTS.merge(options))
  end

  AS_JSON_OPTS = {
    only: [
      :id,
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
      :created_at,
      :updated_at
    ],
    include: [:vehicle]
  }.freeze
end
