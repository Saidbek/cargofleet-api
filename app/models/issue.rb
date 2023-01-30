class Issue < ApplicationRecord
  belongs_to :vehicle

  enum priority: [:low, :medium, :high]
end
