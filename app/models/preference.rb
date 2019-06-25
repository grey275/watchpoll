class Preference < ApplicationRecord
  belongs_to :preference_order
  belongs_to :candidate_video
end