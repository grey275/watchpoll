class UserSession < ApplicationRecord
  belongs_to :room
  belongs_to :user
  has_many :preference_orders
  alias_attribute :start, :created_at
end
#session.end.nil?