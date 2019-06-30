module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :user

    def connect
    end
  end
end
