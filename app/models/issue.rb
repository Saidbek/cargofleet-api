class Issue < ApplicationRecord
  acts_as_tenant :account

  PRIORITIES = [:low, :medium, :high].freeze

  enum priority: PRIORITIES
  scope :open_count, -> { where(completed: false).count }
  # scope :completed_count, -> { where(completed: true).count }
  scope :overdue_count, -> { where('due_date < ? AND completed = ?', Date.today, false).count }
  scope :completed_by_priority_counts, -> {
    priority_counts = where(completed: true)
                     .group(:priority)
                     .count
    PRIORITIES.map do |priority|
      priority_counts[priority.to_s] || 0
    end
  }

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
      :completed,
      :created_at,
      :updated_at
    ],
    include: [:vehicle]
  }.freeze
end
