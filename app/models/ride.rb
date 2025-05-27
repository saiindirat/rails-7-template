# == Schema Information
#
# Table name: rides
#
#  id              :bigint           not null, primary key
#  available_seats :integer
#  departure_time  :datetime
#  location        :string
#  map_url         :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :integer
#
class Ride < ApplicationRecord
  belongs_to :user
  has_many :ride_participants, dependent: :destroy
  has_many :passengers, through: :ride_participants, source: :user
end
