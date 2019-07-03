class UserSession < ApplicationRecord
  belongs_to :room
  belongs_to :user
  has_many :preference_orders
  alias_attribute :start, :created_at

  def self.nuke
    Preference.destroy_all
    PreferenceOrder.destroy_all
    UserSession.destroy_all
  end
end
#session.end.nil?