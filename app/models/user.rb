class User < ApplicationRecord

    def deposit(amount, transfer_uid)
        receiver_new_balance = balance + amount
                deposit = Transaction.create(
                    user_id: id,
                    transfer_uid: transfer_uid,
                    amount: amount,
                    category: "deposit",
                    status: "pending",
                )
        update(balance: receiver_new_balance) && deposit.update(status: "processed")
    end
    def withdrawal(amount, transfer_uid)
        sender_new_balance = balance - amount
        withdrawal = Transaction.create(
            user_id: id,
            transfer_uid: transfer_uid,
            amount: amount,
            category: "withdrawal",
            status: "pending",
        )
        update(balance: sender_new_balance) && withdrawal.update(status: "processed")
    end
end
