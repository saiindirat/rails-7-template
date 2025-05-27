# == Schema Information
#
# Table name: ride_participants
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  ride_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_ride_participants_on_ride_id  (ride_id)
#  index_ride_participants_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (ride_id => rides.id)
#  fk_rails_...  (user_id => users.id)
#
class RideParticipant < ApplicationRecord
  belongs_to :ride
  belongs_to :user

  # Validate if seats are available before creating a participant
  validate :ride_has_seats, on: :create

  # Callbacks to update seat count
  after_create :decrement_ride_seats
  after_destroy :increment_ride_seats

  private

  # Check if ride has available seats
  def ride_has_seats
    if ride.available_seats <= 0
      errors.add(:ride, "has no available seats.")
    end
  end

  # Decrease available seats by 1 when a user joins
  def decrement_ride_seats
    ride.update(available_seats: ride.available_seats - 1)
  end

  # Increase available seats by 1 when a user leaves
  def increment_ride_seats
    ride.update(available_seats: ride.available_seats + 1)
  end
end
