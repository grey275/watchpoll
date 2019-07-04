class UserSession < ApplicationRecord
  belongs_to :room
  belongs_to :user
  has_many :preference_orders
  alias_attribute :start, :created_at
  scope :by_created, -> { order(created_at: :asc) }
  scope :earliest_created, -> { by_created.first }
  scope :most_recently_created, -> { by_created.last }

  def orda_count_formula(length, position)
    length - position
  end

  def self.nuke
    Preference.destroy_all
    PreferenceOrder.destroy_all
    UserSession.destroy_all
  end
end
#session.end.nil?