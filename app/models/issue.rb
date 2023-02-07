class Issue < ApplicationRecord
  acts_as_tenant :account

  enum priority: [:low, :medium, :high]

  # associations
  belongs_to :vehicle

  # validations
  validates :title,
            :priority,
            :due_date, presence: true

  def as_json(options = {})
    super(AS_JSON_OPTS.merge(options))
  end

  AS_JSON_OPTS = {
    only: [
      :id,
      :vehicle_id,
      :title,
      :description,
      :priority,
      :due_date,
      :created_at,
      :updated_at
    ],
    include: [:vehicle]
  }.freeze
end
