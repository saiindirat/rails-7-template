class RidesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]
  before_action :set_ride, only: [:show, :destroy]

  def index
    @rides = Ride.order(departure_time: :asc)
  end

  def show
  end

  def new
    @ride = Ride.new
  end

  def create
    @ride = Ride.new(ride_params)
    @ride.user_id = current_user.id

    if @ride.save
      redirect_to @ride, notice: "Ride posted successfully!"
    else
      flash.now[:alert] = "Ride failed to post."
      render :new
    end
  end

  def destroy
    if @ride.user_id == current_user.id
      @ride.destroy
      redirect_to rides_path, notice: "Ride deleted."
    else
      redirect_to rides_path, alert: "Not authorized to delete this ride."
    end
  end

  private

  def set_ride
    @ride = Ride.find(params[:id])
  end

  def ride_params
    params.require(:ride).permit(
      :origin,
      :destination,
      :departure_time,
      :available_seats,
      :map_url,       # <--- added this
      :notes
    )
  end
end
