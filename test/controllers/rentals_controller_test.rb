require "test_helper"

describe RentalsController do
  describe "check_out" do
    let(:rental) {
      {
        movie_id: Movie.first.id,
        customer_id: Customer.first.id,
        due_date: "2017-11-19"
      }
    }
    it "checks out a movie" do
      movie = Movie.find(rental[:movie_id])
      before_rental = Rental.count
      before_movie = movie.available_inventory
      post check_out_path, params: rental

      must_respond_with :ok
      Rental.count.must_equal before_rental + 1
      movie.available_inventory.must_equal before_movie - 1
    end

    it "won't change the db if data is missing" do
      invalid_rental = {
        customer_id: Customer.first.id,
        due_date: "2017-11-19"
      }
    end
  end
end
