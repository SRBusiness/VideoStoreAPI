class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer

  # don't need to validate that rentals are unique, a customer could check out the same movie on numerouse occasions
end
