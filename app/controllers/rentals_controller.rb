class RentalsController < ApplicationController
  def check_out
    # make sure movie_id and customer_id exists

    customer = Customer.find_by(id: rental_params[:customer_id])
    movie = Movie.find_by(id: rental_params[:movie_id])
    binding.pry
    if customer && movie && movie.available_inventory >= 1
      rental = Rental.new(movie: movie, customer: customer, due_date: rental_params[:due_date])
      rental.save
      movie.available_inventory -= 1
      movie.save
    else
      render json: {errors: movie.errors.messages},
      status: :bad_request
    end
    # make sure movie is available
    # create instance of rental
    # decriment available_inventory for movie


  end

  def checkin
  end

private
  def rental_params
    params.permit(:movie_id, :customer_id, :due_date)
  end

end
