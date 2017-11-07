require "test_helper"

describe Rental do
  describe "relationships" do
    it "has a customer" do
      rental1.must_respond_to :customer
      rental1.customer.must_be_kind_of Customer
    end

    it "has a movie" do
      rental1.must_respond_to :movie
      rental1.movie.must_be_kind_of Movie
    end
  end
end
