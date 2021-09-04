class Payment < ApplicationRecord

    def self.has_payment?(user)
        Payment.where(status: "approved", user_id: user.id).first
    end
end
