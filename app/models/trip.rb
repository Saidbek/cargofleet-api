class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :vehicle

  validates :driver, :vehicle, presence: true

  # methods
  def complete
    update(completed: true)
  end
end
