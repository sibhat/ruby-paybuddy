class ProcessTransfersJob
    include SuckerPunch::Job

    def perform(transfer_uid)
        sleep 5
        transactions = Transactions.where(transfer_uid: transfer_uid)

        transactions.each do |transaction|
            transaction.process!
        end
    end

end