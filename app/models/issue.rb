class Issue < ApplicationRecord
  acts_as_tenant :account

  enum priority: [:low, :medium, :high]

  belongs_to :vehicle

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
      :reported_at,
      :created_at,
      :updated_at
    ],
    include: [:vehicle]
  }.freeze
end
