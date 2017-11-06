class Customer < ApplicationRecord
  # relationships
  has_many :rentals
  has_many :movies, through: :rentals

<<<<<<< HEAD

=======
  # validations
  validates :name, presence: true
  validates :registered_at, presence: true
  validates :postal_code, presence: true
  validates :phone, presence: true
>>>>>>> b1fd10d10b7f6e841231d7bf743fd10690b855e8
end
