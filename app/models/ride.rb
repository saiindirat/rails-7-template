# == Schema Information
#
# Table name: rides
#
#  id              :bigint           not null, primary key
#  available_seats :integer
#  departure_time  :datetime
#  destination     :string
#  image           :string
#  location        :string
#  map_url         :string
#  notes           :text
#  origin          :string
#  price           :decimal(, )
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :integer
#
class Ride < ApplicationRecord
  belongs_to :user
  has_many :ride_participants, dependent: :destroy
  has_many :passengers, through: :ride_participants, source: :user

  has_one_attached :image

  def spots_taken
    passengers.count
  end

  def seats_remaining
    [available_seats - spots_taken, 0].max
  end
end
