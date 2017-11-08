class RentalsController < ApplicationController
  # before_action

  def create
    movie = Movie.find_by_id(params[:movie_id])
    customer = Customer.find_by_id( params[:customer_id])

    rental = Rental.new(movie: movie, customer: customer, due_date: rental_params[:due_date])

    if rental.valid?
      if movie.can_rent
        rental.save
        movie.decriment_movie
        customer.increment_movie
        render(
          json: {id: movie.id},
          status: :ok
        )
      else
        render json: {errors: {movie_id: "Movie ID: #{rental_params[:movie_id]} is out of stock and cannot be rented right now. Please try again later"} },
        status: :bad_request
      end
    else
      render json: {errors: rental.errors.messages},
      status: :bad_request
    end
  end

  def checkin
  end

private
  def rental_params
    params.permit(:movie_id, :customer_id, :due_date)
  end
end
