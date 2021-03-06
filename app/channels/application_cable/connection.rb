module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_supplier

    def connect
      self.current_supplier = find_verified_user
      logger.add_tags "ActionCable", "User #{current_supplier.id}"
    end

    protected

    def find_verified_user
      if verified_user = env['warden'].user
        verified_user
      else
        reject_unauthorized_connection
      end
    end
  end
end
