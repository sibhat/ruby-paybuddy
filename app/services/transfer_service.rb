class TransferService
    class TransferError < StandardError
    end
    attr_reader :sender, :receiver, :amount, 
    def intialize(sender, receiver, amount)
        @sender = sender
        @receiver = receiver
        @amount = amount
        @transfer_uid = SecureRandom.uuid
    end
    def process!
        raise TransferError, "Unable to initiate transfer: invalid amount" unless valid_transfer?

        if receiver.deposit(amoiunt], transfer_uid) &&
        sender.withdrawal(amoiunt], transfer_uid)
            return true
        else
            raise TransferError, "Unable to initiate transfer"
        end
    end

    private

    def valid_transfer?
        valid_amount? && enough_funds_for_transfer?
    end
    def valid_amount?
        amount.is_a? (Integer) && amount > 0
    end
    def enough_funds_for_transfer?
        sender.balance >= amount
    end

end