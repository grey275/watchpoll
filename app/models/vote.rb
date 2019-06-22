class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :candidate_video
end
