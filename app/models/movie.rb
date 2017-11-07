class Movie < ApplicationRecord
  has_many :rentals
  has_many :customers, through: :rentals

  validates :title, presence: true
  validates :overview, presence: true
  validates :release_date, presence: true
  validates :inventory, presence: true

  # method that will set available_inventory to the value of inventory
  after_create :set_available_inventory

private
  def set_available_inventory
    self.update_columns(available_inventory: inventory)
  end
end
