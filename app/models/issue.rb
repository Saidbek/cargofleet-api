class Issue < ApplicationRecord
  acts_as_tenant :account

  enum priority: [:low, :medium, :high]

  belongs_to :vehicle

  def as_json(options = {})
    super(AS_JSON_OPTS.merge(options))
  end

  AS_JSON_OPTS = {
    include: [:vehicle],
  }.freeze
end
