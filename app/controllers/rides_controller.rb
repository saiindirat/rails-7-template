class RidesController < ApplicationController
  # Only require login for actions that need it
  before_action :authenticate_user!, only: [:new, :create, :destroy]

  def index
    @rides = Ride.order(departure_time: :asc)
    render template: "rides/index"
  end

  def show
    @ride = Ride.find(params.fetch(:id))
    render template: "rides/show"
  end

  def new
    @ride = Ride.new
    render template: "rides/new"
  end

  def create
    @ride = Ride.new(ride_params)
    @ride.user_id = current_user.id

    if @ride.save
      redirect_to("/rides/#{@ride.id}", notice: "Ride posted successfully!")
    else
      render :new, alert: "Ride failed to post."
    end
  end

  def destroy
    @ride = Ride.find(params.fetch(:id))
    if @ride.user_id == current_user.id
      @ride.destroy
      redirect_to("/rides", notice: "Ride deleted.")
    else
      redirect_to("/rides", alert: "Not authorized to delete this ride.")
    end
  end

  private

  def ride_params
    params.require(:ride).permit(
      :origin,
      :destination,
      :departure_time,
      :available_seats,
      :notes
    )
  end
end
