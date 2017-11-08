class RentalsController < ApplicationController
  # before_action

  def check_out
    find_movie_customer
    rental = Rental.new(movie: @movie, customer: @customer, due_date: rental_params[:due_date])

    if movie_rentable && rental.save
      rent_movie
      render(
        # json: {id: movie.id},
        status: :ok
      )
    else
      # TODO: need to make checking to see if a movie is rentalable is part of the save process for rental
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

  def find_movie_customer
    @movie = Movie.find_by(id: rental_params[:movie_id])
    @customer = Customer.find_by(id: rental_params[:customer_id])
  end

  def movie_rentable
    if @movie
      return @movie.can_rent
    else
      return false
    end
  end

  def rent_movie
    @movie.decriment_movie
    @customer.increment_movie
  end

end
