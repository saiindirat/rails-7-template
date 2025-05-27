class RideParticipantsController < ApplicationController
  before_action :authenticate_user!

  def create
    ride = Ride.find(params[:ride_id])
    current_user.ride_participants.create(ride: ride)
    redirect_to ride_path(ride), notice: "You joined the ride!"
  end

  def destroy
    ride_participant = current_user.ride_participants.find_by(ride_id: params[:ride_id])
    ride_participant.destroy
    redirect_to ride_path(params[:ride_id]), notice: "You left the ride."
  end
end
