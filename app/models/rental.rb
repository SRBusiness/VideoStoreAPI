class Rental < ApplicationRecord
  # relationships
  belongs_to :movie
  belongs_to :customer

  # validations
  validates :due_date, presence: true
  # don't need to validate that rentals are unique, a customer could check out the same movie on numerouse occasions

  
end
