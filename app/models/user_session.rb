class UserSession < ApplicationRecord
  belongs_to :room
  belongs_to :user
  has_many :preference_orders
end
#session.end.nil?