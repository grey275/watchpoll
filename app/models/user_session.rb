class UserSession < ApplicationRecord
  belongs_to :room
  belongs_to :user
end
#session.end.nil?