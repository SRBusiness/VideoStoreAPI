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
      # arrange
      before_rental = Rental.count
      before_movie = Movie.find(rental[:movie_id]).available_inventory
      before_movies_rented = Customer.find(rental[:customer_id]).movies_checked_out_count

      # act
      post check_out_path, params: rental

      # assert
      must_respond_with :ok

      # rental count incremented
      Rental.count.must_equal before_rental + 1
      # decrimented available_inventory
      Movie.find(rental[:movie_id]).available_inventory.must_equal before_movie - 1
      # incremented movies_checked_out_count
      Customer.find(rental[:customer_id]).movies_checked_out_count.must_equal before_movies_rented + 1
    end

    it "won't change the db if data is missing" do
      # arrange
      invalid_rental = {
        customer_id: Customer.first.id,
        due_date: "2017-11-19"
      }
      before_movies_rented = Customer.find(invalid_rental[:customer_id]).movies_checked_out_count
      before = Rental.count

      # act
      post check_out_path, params: invalid_rental

      # assert
      Rental.count.must_equal before
      must_respond_with :bad_request

      Customer.find(invalid_rental[:customer_id]).movies_checked_out_count.must_equal before_movies_rented

      body = JSON.parse(response.body)
      body.must_equal "errors" => {"movie_id" => ["can't be blank"]}
    end
  end
end
