class Driver < ApplicationRecord
  acts_as_tenant :account

  scope :active_count, -> { where(active: true).count }
  scope :archived_count, -> { where(active: false).count }

  # associations
  has_many :assignments
  has_many :vehicles, through: :assignments
  has_one :active_assignment, -> { where(active: true) }, class_name: 'Assignment'
  has_one :vehicle, through: :active_assignment

  # validations
  validates :first_name,
            :last_name,
            :birth_date,
            :email,
            :address1,
            :city,
            :state,
            :postal_code,
            :license_number, presence: true

  # methods
  def self.cached_active_count
    Rails.cache.fetch(Driver.last, expires_in: 1.minute) do
      Driver.active_count
    end
  end

  def self.cached_archived_count
    Rails.cache.fetch(Driver.last, expires_in: 1.minute) do
      Driver.archived_count
    end
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
      :license_state,
      :created_at,
      :updated_at
    ],
    include: [:vehicle]
  }.freeze
end
