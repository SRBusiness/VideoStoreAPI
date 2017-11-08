class RentalsController < ApplicationController
  # before_action

  def create
    movie = Movie.find_by_id(params[:movie_id])
    customer = Customer.find_by_id( params[:customer_id])

    rental = Rental.new(movie: movie, customer: customer, due_date: rental_params[:due_date])

    if rental.valid?
      if movie.can_rent
        rental.save
        movie.update_available_inventory(-1)
        customer.update_customer_movies(1)
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

  def update
    rental = Rental.find_by(movie: params[:movie_id], customer: params[:customer_id] )

    # if we can find rental, if the rental is not already renturned
    if rental
      if rental.returned
        render json: {errors: {movie_id: "Movie ID: #{rental_params[:movie_id]} was already returned"} },
        status: :bad_request
      else
        rental.update(returned: true)
        render(
          json: {id: params[:movie_id]},
          status: :ok
        )
      end
    else
      render json: {errors: "Rental does not exist."},
      status: :bad_request
    end
  end

private
  def rental_params
    params.permit(:movie_id, :customer_id, :due_date)
  end
end
