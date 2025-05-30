class RideParticipantsController < ApplicationController
  before_action :authenticate_user!

  def create
    ride = Ride.find(params[:ride_id])

    unless ride.passengers.include?(current_user)
      ride.ride_participants.create(user: current_user) if ride.seats_remaining > 0
    end

    redirect_to ride_path(ride), notice: "You joined the ride!"
  end

  def destroy
    ride = Ride.find(params[:ride_id])
    ride_participant = ride.ride_participants.find_by(user_id: current_user.id)
    ride_participant&.destroy

    redirect_to ride_path(ride), notice: "You left the ride."
  end
end
