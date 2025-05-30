class RidesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_ride, only: [:show, :edit, :update, :destroy]

  def index
    @rides = Ride.order(departure_time: :asc)
  end

  def show; end

  def new
    @ride = Ride.new
  end

  def create
    @ride = Ride.new(ride_params)
    @ride.user = current_user

    if @ride.save
      redirect_to @ride, notice: "Ride posted successfully!"
    else
      flash.now[:alert] = "Ride failed to post."
      render :new
    end
  end

  def edit
    redirect_to ride_path(@ride), alert: "Not authorized" unless @ride.user == current_user
  end

  def update
    if @ride.user == current_user && @ride.update(ride_params)
      redirect_to @ride, notice: "Ride updated successfully!"
    else
      flash.now[:alert] = "Update failed."
      render :edit
    end
  end

  def destroy
    if @ride.user == current_user
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
    params.require(:ride).permit(:origin, :destination, :departure_time, :available_seats, :notes, :price, :map_url, :image)
  end
end
