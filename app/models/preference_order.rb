class PreferenceOrder < ApplicationRecord
  has_many :preferences
  belongs_to :user_session
end
