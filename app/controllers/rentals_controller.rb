class RentalsController < ApplicationController
  def check_out
    # make sure movie_id and customer_id exists
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
