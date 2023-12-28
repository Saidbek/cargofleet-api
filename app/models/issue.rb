class Issue < ApplicationRecord
  acts_as_tenant :account

  enum priority: [:low, :medium, :high]
  scope :overdue_count, -> { where('due_date < ?', Date.today).count }
  scope :open_count, -> { where('due_date >= ?', Date.today).count }

  # associations
  belongs_to :vehicle

  # validations
  validates :priority,
            :due_date, presence: true

  # methods
  def as_json(options = {})
    super(AS_JSON_OPTS.merge(options))
  end

  AS_JSON_OPTS = {
    only: [
      :id,
      :vehicle_id,
      :description,
      :priority,
      :due_date,
      :created_at,
      :updated_at
    ],
    include: [:vehicle]
  }.freeze
end
